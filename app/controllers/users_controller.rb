class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:notice] = "Could not sign you up #{user.errors.full_messages.to_sentence}"
      redirect_to '/signup'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation, :admin)
  end
end
