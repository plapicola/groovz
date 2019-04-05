require 'rails_helper'

describe 'Creating parties' do
  context 'as a user' do
    before :each do
      @user = create(:user)
      login(@user)
    end

    it 'I can click create a party on the root path and be prompted for a name' do
      visit root_path

      click_button 'Create Party'

      expect(current_path).to eq(soundcheck_path)

      expect(page).to have_content 'Room Name'
    end

    it 'I can fill out the name of a party and be taken to the party show page' do
      visit soundcheck_path

      fill_in :name, with: 'Test Party!'

      click_button 'Start Party'

      expect(current_path).to eq(host_party_path)
    end

    it 'I can click the go back button to cancel my party creation' do
      visit soundcheck_path

      click_button 'Go Back'

      expect(current_path).to eq(root_path)
    end
  end
end
