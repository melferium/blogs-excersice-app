class ApplicationController < ActionController::Base
  #before_action :redirect_to_subdomain
  helper_method :current_user, :logged_in?, :user_subdomain

  def redirect_to_subdomain # redirects to subdomain on signup
    return if !current_user.present?
    if current_user.present? && request.subdomain != current_user.subdomain
      redirect_to root_url(subdomain: current_user.subdomain)
    end
  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def has_subdomain
    user_signed_in? && current_user.subdomain
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
       flash[:danger] = "You must be logged in to perform that action"
    end
  end

end
