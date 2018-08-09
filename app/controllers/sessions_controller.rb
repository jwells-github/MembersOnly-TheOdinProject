class SessionsController < ApplicationController
  
  # Directs to the login form
  def new
  end
  
  def create
    # gets the submitted email
    user = User.find_by(email: params[:session][:email].downcase)
    # If the given user was valid, and the given password was correct
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url  
  end
end
