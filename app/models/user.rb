class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_secure_token :authentication_token
  
  # Fetching User from Api Key
  def self.from_api_key(api_key, renew = false)
    cached_key = self.cached_api_key(api_key)
    authentication_token = Rails.cache.read cached_key
    if authentication_token
      user = User.find_by_authentication_token authentication_token
      # Renew the token
      if renew && user
        Rails.cache.write cached_key, authentication_token,
          expires_in: Genealogy::Settings[:authentication][:session_expiry_time]
      end
    end
    user
  end

  def self.cached_api_key(api_key)
    "api/#{api_key}"
  end

  def generate_api_key
    api_key = formulate_key
    # Write it into cache
    Rails.cache.write(User.cached_api_key(api_key),
     self.authentication_token,
      :expires_in => Genealogy::Settings[:authentication][:session_expiry_time])
    # Return the hash
    api_key
  end

  private

  def formulate_key
    str = Digest::MD5.digest("#{SecureRandom.uuid}_#{Time.now.to_i}")
    Base64.encode64(str).gsub(/[\s=]+/, "").tr('+/','-_')
  end
end
