class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @strike = Strike.where(user: @user)
  end
end
