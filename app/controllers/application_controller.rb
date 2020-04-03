class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Exception, with: :error500
  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

  def error404(_e)
    render 'error404', status: 404, formats: [:html]
  end

  def error500(e)
    logger.error [e, *e.backtrace].join('¥')
    render 'error500', status: 500, formats: [:html]
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
