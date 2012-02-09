module SessionsHelper

  def sign_in(user)
    session[:current_user_id] = [user.id]
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end

  def current_user?(user)
    user == current_user
  end
  
  def signed_in?
    !current_user.nil?
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def sign_out
    @_current_user = session[:current_user_id] = nil
  end
  
  private
  
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
end
