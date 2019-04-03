require 'rails_helper'

RSpec.describe 'Login Page' do
  context 'as a visitor' do
    it 'I am taken to the login page when I visit the site' do
      visit root_path

      expect(current_path).to eq(login_path)

      expect(page).to have_button 'Log In With Spotify'
    end

    it 'I can log in' do
      visit login_path

      stub_spotify

      click_button 'Log In With Spotify'

      expect(current_path).to eq(root_path)
    end
  end
end
