class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to login_path
    end
  end

  private
  def user_params
    params.permit(:login, :password, :name, :surname, :group)
  end
end
