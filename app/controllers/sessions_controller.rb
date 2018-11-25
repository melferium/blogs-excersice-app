class SessionsController < ApplicationController

  def new

  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      Apartment::Tenant.switch!(user.subdomain)
      flash[:success] = "Successfully login"
      #redirect_to root_path
      redirect_to root_url(subdomain: "#{Apartment::Tenant.current}")
    else
      flash.now[:danger] = "Incorrect password / username"
      render 'new'
    end
    
  end

  def destroy
    session[:user_id] = nil
    Apartment::Tenant.reset
    flash[:success] = "You have logged out"
    redirect_to logout_path

  end



end