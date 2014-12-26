require 'csv'

class UsersController < ApplicationController
  before_action :require_teacher
  skip_before_filter :require_login, only: [:new, :create]

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to login_path
    end
  end

  def index
  end

  def save
    content = params[:users].read
    CSV.parse(content, :headers => true) do |row|
      name = row["name"]
      surname = row["surname"]
      group = row["group"]
      login = Translit.convert(name.force_encoding 'utf-8') + Translit.convert(surname.force_encoding 'utf-8')
      password = login
      user = User.new
      user.name = name.force_encoding 'utf-8'
      user.surname = surname.force_encoding 'utf-8'
      user.group = group.force_encoding 'utf-8'
      user.login = login
      user.password = password
      user.teacher = 0
      user.save
    end
    redirect_to :back
  end

  private
  def user_params
    params.permit(:login, :password, :name, :surname, :group)
  end
end
