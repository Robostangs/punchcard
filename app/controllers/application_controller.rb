class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def authenticate_admin!
    unless current_user.admin?
      redirect_to new_user_session_path
      if current_user.nil
        flash[:alert] = "Please log in."
      else
        flash[:alert] = "You are not an admin. Redirected."
      end
    end
  end
end
