class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    current_user.present?
  end

  def current_user
    super || User.where(soft_token: soft_token).first_or_initialize
  end

  private

  def soft_token
    session[:user_token] ||= SecureRandom.hex(8)
  end

end
