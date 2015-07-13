class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    puts "CREATE METHOD CALLED IN USER CONTROLLER"
    p params
    @user = User.new(user_params)
    @user.password = params[:password]
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Melanie's Travel Blog!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  # def login
  #   @user = User.find_by_username(params[:username])
  #   if @user.password == params[:password]
  #     give_token
  #   else
  #     redirect_to root_url
  #   end
  # end

  def forgot_password
  end

  private

    def user_params
      params.require(:user).permit(:username, :password_digest)
    end

end
