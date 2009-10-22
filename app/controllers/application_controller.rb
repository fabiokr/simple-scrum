# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  user_stamp Product, Story, Sprint, Taskk

  helper :all, :breadcrumbs
  helper_method :current_user_session, :current_user

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  layout proc { |controller| (controller.params[:format] == 'js') || controller.request.xhr? ? false : 'application' }

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      redirect_to_login t('app.login.require_login')
      return false
    end
  end

  def require_admin
    unless !require_user && current_user.admin?
      redirect_to_login t('app.login.require_admin')
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  private

  def redirect_to_login(msg)
    store_location
    flash[:notice] = msg
    redirect_to new_session_path
  end
end

