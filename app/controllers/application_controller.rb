class ApplicationController < ActionController::Base
  before_action :redirect_to_subdomain
  before_action :redirect_to_root_if_not_logged_in
  before_action :switch_tenant_base_on_domain
  helper_method :current_user, :logged_in?, :user_subdomain

  def redirect_to_root_if_not_logged_in
    return if !request.subdomain.present?
    if !current_user.present?
      redirect_to root_url(subdomain: '')
    end

  end

  def redirect_to_subdomain 
    return if !request.subdomain.present?
    if current_user.present? && request.subdomain != current_user.subdomain
      redirect_to root_url(subdomain: current_user.subdomain)
    end
  end

  def switch_tenant_base_on_domain
    return if request.subdomain.present?
    if current_user.present? && request.domain == current_user.domain
      Apartment::Tenant.switch!(current_user.subdomain)
    end

  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def has_subdomain
    user_signed_in? && current_user.subdomain
  end

  def logged_in?
    current_user.present?
  end

  def require_user
    if !logged_in?
       flash[:danger] = "You must be logged in to perform that action"
    end
  end

end
