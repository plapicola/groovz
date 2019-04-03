# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def require_login
    redirect_to login_path
  end
end
