require 'rails_helper'

describe 'party show page' do
  context 'a user who has joined a party' do
    before(:each) do
      @host = create(:user)
      @user = create(:user, uid: "123456")
      login(@user)
      @loggedin = User.last
      @party = create(:party, name: 'Test Party', user: @host, users: [@loggedin])
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

    xit 'shows the song currently playing in they playlist' do
    end

    xit 'lets me add the song to my own spitify account' do
    end

    it 'has a button for me to leave the party' do
      visit party_path

      expect(page).to have_button("Bail Out")
      click_button('Bail Out')

      expect(current_path).to eq(root_path)
      expect(Party.last.users).to_not eq([@loggedin])
    end
  end
end
