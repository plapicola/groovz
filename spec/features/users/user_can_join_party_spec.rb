require 'rails_helper'

describe 'joining parties' do
  context 'as a user' do
    before :each do
      @user = create(:user)
      login(@user)
    end

    it 'I can click join a party and be promted for a room code' do
      visit root_path

      click_button 'Join Party'

      expect(current_path).to eq(admissions_path)

      expect(page).to have_content 'Room Code'
    end

    it 'I can enter a valid room code and join be routed to the room' do
      host = create(:user)
      create(:party, user: host)

      visit admissions_path

      fill_in :code, with: 'a1b2c3'
      click_button('Join')

      expect(current_path).to eq(party_path)
    end

    it 'i cannot join a party without a valid room code' do
      host = create(:user)
      create(:party, user: host)

      visit admissions_path

      fill_in :code, with: 'not valid'
      click_button('Join')

      expect(current_path).to eq(admissions_path)
    end

    it 'i click go back from addmisions to root path' do
      visit admissions_path

      click_button('Go Back')

      expect(current_path).to eq(root_path)
    end
  end
end
