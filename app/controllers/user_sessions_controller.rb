class UserSessionsController < Devise::SessionsController
  skip_before_action :authenticate_user_token!, only: :create
  skip_before_action :verify_signed_out_user

  swagger_controller :user_sessions, 'User Session Management'

  swagger_api :create do
    summary 'Sign in a user to the application and returns back authentication token'
    param :form, :'user[email]', :string, :required, 'Email'
    param :form, :'user[password]', :password, :required, 'Password'
    response :created
    response :unauthorized
  end

  def create
    resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: { api_key: resource.generate_api_key }, status: :created
  end

  swagger_api :destroy do
    summary 'Signout a user'
    response :ok
    response :unprocessable_entity
  end

  def destroy
    if User.from_api_key(request.env['HTTP_X_API_KEY'])
      Rails.cache.delete User.cached_api_key(request.env['HTTP_X_API_KEY'])
      head :ok
    else
      head :unauthorized
    end
  end

  private

  def formulate_key
    str = Digest::MD5.digest("#{SecureRandom.uuid}_#{Time.now.to_i}")
    Base64.encode64(str).gsub(/[\s=]+/, "").tr('+/','-_')
  end
end
