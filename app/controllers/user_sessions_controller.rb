class UserSessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
  end

  def create
    login(params)
    redirect_to root_path
  end

  def destroy
    logout
    redirect_to login_path
  end
end
