# frozen_string_literal: true

# Controller for login/logout functions
class SessionsController < ApplicationController
  def new; end

  def create
    extract_spotify
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  private

  def extract_spotify
    @user = User.find_or_create_by(uid: spotify_info.uid)
    @user.update(spotify_session)
    @user.update(musical_taste_info)
  end

  def spotify_info
    request.env['omniauth.auth']
  end

  def spotify_session
    spotify_info.credentials.to_h
  end

  def musical_taste_info
    @user.add_user_artists
    @user.get_user_info
  end
end
