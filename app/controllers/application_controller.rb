class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def authenticate_admin!
    if current_user && current_user.admin?
      # Good to go.
    elsif current_user && !(current_user.admin?)
      redirect_to root_path
      flash[:alert] = "You are not an admin. Redirected."
    end
  end
end
