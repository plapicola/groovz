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
      create(:party)

      visit admissions_path

      fill_in :room_code, with: 'a1b2c3'

      expect(current_path).to eq(party_path)
    end
  end
end
