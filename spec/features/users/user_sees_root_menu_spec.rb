require 'rails_helper'

describe 'Root menu' do
  context 'as a user' do
    before :each do
      @user = create(:user, token: ENV['SPOTIFY_TOKEN'])
    end

    it 'I see a link to create a party' do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user)

      visit root_path

      click_button 'Create Party'

      expect(current_path).to eq(soundcheck_path)
    end

    it 'I see a link to join a party' do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user)

      visit root_path

      click_button 'Join Party'

      expect(current_path).to eq(admissions_path)
    end

    it 'I see a link to log out of the application' do
      login(@user)

      visit root_path

      click_button 'Log Out'

      expect(current_path).to eq(login_path)
    end

    it 'I see a link to the legal path' do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user)

      visit root_path

      click_button 'Legal'

      expect(current_path).to eq(legal_path)
    end
  end

  context 'as a visitor' do
    it 'I am redirected to the login path' do
      visit root_path

      expect(current_path).to eq(login_path)
    end
  end
end
