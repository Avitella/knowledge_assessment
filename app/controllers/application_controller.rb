class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  skip_before_action :verify_authenticity_token

  private
  def require_login
    if not current_user
      redirect_to login_path
    end
  end

  def current_user
    user_id = cookies[:knowledge_assessment]
    if user_id and UserSession.find_by(user_id: user_id)
      @user = User.find(user_id)
      return @user
    end
    return nil
  end

  def require_teacher
    user = current_user
    if not user or user.teacher != 1
      redirect_to root_path
    end
  end

  def login(data)
    if current_user
      return nil
    end
    user = User.find_by(login: data[:login], password: data[:password])
    if user
      session = UserSession.new
      session.user_id = user.id
      if session.save
        cookies[:knowledge_assessment] = user.id
        return session
      end
    end
    return nil
  end

  def logout
    user = current_user
    if not user
      return nil
    end
    session = UserSession.find_by(user_id: user.id)
    if session
      session.destroy
    end
  end
end
