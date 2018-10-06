class ApplicationController < ActionController::Base
  include Swagger::Docs::ImpotentMethods

  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  before_action :authenticate_user_token!

  def authenticate_user_token!
    unauthorized_access if current_user.blank?
  end

  def current_user
    @current_user ||= User.from_api_key(request.env['HTTP_X_API_KEY'], true)
  end

  private

  def unauthorized_access
    render_error_json(_('errors.unauthorized_access'), :unauthorized)
  end

  def render_error_json(message, status = :bad_request)
    render json: { error: message }, status: status
  end
end
