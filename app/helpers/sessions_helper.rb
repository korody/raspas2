# encoding: utf-8
module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= Author.find_by(remember_token: cookies[:remember_token]) if cookies[:remember_token]
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    current_user.present?
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    redirect_to signin_path, notice: "É VOCÊ MESMO?"
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  private

  def store_location
    session[:return_to] = request.fullpath
  end

end