class SessionsController < ApplicationController

  def new

  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      
      #Apartment::Tenant.switch!(user.subdomain)
      flash.now[:success] = "Successfully login"
      #redirect_to root_path
      #redirect_to root_url(params: {session: :user_id}, subdomain: user.subdomain )
      redirect_to root_url(subdomain: user.subdomain )
      session[:user_id] = user.id
    else
      flash.now[:danger] = "Incorrect password / username"
      render 'new'
    end
    
  end

  def destroy
    #Apartment::Tenant.reset
    session[:user_id] = nil
    
    flash.now[:success] = "You have logged out"
    redirect_to root_url(subdomain: '', params: {session: nil})

  end



end