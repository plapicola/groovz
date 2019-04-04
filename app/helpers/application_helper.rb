# frozen_string_literal: true

# Module for common application methods
module ApplicationHelper
  def login(user)
    stub_spotify
    visit login_path
    click_button 'Log In With Spotify'
  end
end
