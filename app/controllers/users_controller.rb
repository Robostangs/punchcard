class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @strike = Strike.where(user: @user)
  end

  def leaderboards
    @user = User.all.sort {|a,b| b.total_time <=> a.total_time}
  end
end
