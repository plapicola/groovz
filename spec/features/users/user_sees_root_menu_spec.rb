require 'rails_helper'

describe 'Root menu' do
  context 'as a user' do
    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(@user)
    end

    it 'I see a link to create a party' do
      visit root_path

      click_button 'Create Party'

      expect(current_path).to eq(soundcheck_path)
    end

    it 'I see a link to join a party' do
      visit root_path

      click_button 'Join Party'

      expect(current_path).to eq(admissions_path)
    end
  end

  context 'as a visitor' do
    it 'I am redirected to the login path' do
      visit root_path

      expect(current_path).to eq(login_path)
    end
  end
end
