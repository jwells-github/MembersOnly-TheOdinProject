module SessionsHelper
    
    # Saves the current user's id to the session
    def log_in(user)
        session[:user_id] = user.id
    end
    
    # Returns the current user if already found, or finds the current user
    # with the saved user id
    def current_user
       @current_user ||= User.find_by(id: session[:user_id])
    end
    
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
    !current_user.nil?
    end
    
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
