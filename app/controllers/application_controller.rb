# frozen_string_literal: true

# Shared actions for controllers
class ApplicationController < ActionController::Base
  helper_method :current_user

  def reentry
    if current_user&.party && current_user.party.name
      redirect_to host_party_path if user_owns_party?
      redirect_to party_path unless user_owns_party?
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    redirect_to login_path unless current_user
  end

  private

  def user_owns_party?
    current_user.party&.user == current_user if current_user
  end
end
