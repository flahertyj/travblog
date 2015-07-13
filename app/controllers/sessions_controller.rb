class SessionsController < ApplicationController
  def new
  end

  def create
    # user = User.find_by(username: params[:session][:username].downcase)
    puts "CREATE IN SESSIONS CONTROLLER"
    p params
    #
    # if user && user.authenticate(params[:session][:password])
    #   log_in user
    #   redirect_to user
    # else
    #   flash[:danger] = 'Invalid email/password combination' # Not quite right!
    #   render 'new'
    # end

    user = User.find_by_username(params[:session][:username])
    if user.password == params[:session][:password]
      puts "GOOD BOY GOOD PASSWORD"
      log_in user
    else
      puts "YOU TYPED IN WRONG PASSWORD FUCK FACE"
      # redirect_to root_url
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

  def destroy
    log_out
    redirect_to root_url
  end
end
