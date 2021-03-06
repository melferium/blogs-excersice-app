class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      Apartment::Tenant.create(@user.subdomain)
      flash[:success] = "Welcome to blogs #{@user.username}"
      redirect_to root_path
    else
      render 'new'
    end

  end

  def edit
  
  end

  def update
    
    if @user.update(user_params)
      cmd = "sudo virtualhost " + @user.domain
      system(cmd)
      flash[:success] = "Your account was successfully updated"
      redirect_to root_path
    else
      render 'edit'
    end
    
  end

  def show
    
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)

  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)

  end

  def destroy
    Apartment::Tenant.drop(@user.subdomain)
    @user.destroy
    flash[:danger] = "User and all articles create by user have been deleted"
    redirect_to root_path

  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    if logged_id? and !current_user.admin?
      flash[:danger] = "only admin can delete"
      redirect_to root path
    end

  end
  def user_params
    params.require(:user).permit(:username, :email, :password, :subdomain, :domain)
  end
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only modify your own account"
      redirect_to root_path
    end
  end
end
