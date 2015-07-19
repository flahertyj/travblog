class SessionsController < ApplicationController
  def create
    user = User.find_by_username(params[:session][:username])
    # If the user exists AND the password entered is correct.

    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        # Save the user id inside the browser cookie. This is how we keep the user
        # logged in when they navigate around our website.
        session[:user_id] = user.id
        format.html {redirect_to '/'}
      else
      # If user's login doesn't work, send them back to the login form.
        format.html {redirect_to '/login', notice: "Could not log you in, wrong username/password."}
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
