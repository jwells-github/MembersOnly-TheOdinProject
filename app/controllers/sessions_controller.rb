class SessionsController < ApplicationController
  
  # Directs to the login form
  def new
  end
  
  def create
    # gets the submitted email
    user = User.find_by(email: params[:session][:email].downcase)
    # If the given user was valid, and the given password was correct
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "logged in"
      log_in user
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url  
  end
end
