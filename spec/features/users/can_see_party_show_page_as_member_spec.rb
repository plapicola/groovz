require 'rails_helper'

describe 'party show page' do
  context 'a user who has joined a party' do
    before(:each) do
      @host = create(:user)
      @user = create(:user, uid: "123456")
      login(@user)
      loggedin = User.last
      @party = create(:party, name: 'Test Party', user: @host, users: [loggedin])
    end

    it 'shows me the room name and room code on the page' do
      visit party_path

      expect(page).to have_content('Room Name')
      expect(page).to have_content('Room Code')
      within '.room-name' do
        expect(page).to have_content('Test Party')
      end
      within '.room-code' do
        expect(page).to have_content('a1b2c3')
      end
    end
  end
end
