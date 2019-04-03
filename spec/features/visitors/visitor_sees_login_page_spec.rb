require 'rails_helper'

RSpec.describe 'Login Page' do
  context 'as a visitor' do
    it 'I am taken to the login page when I visit the site' do
      visit root_path

      expect(current_path).to eq(login_path)

      expect(page).to have_button 'Log In With Spotify'
    end
  end
end
