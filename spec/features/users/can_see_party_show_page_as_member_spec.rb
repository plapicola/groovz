require 'rails_helper'

describe 'party show page' do
  context 'a user who has joined a party' do
    before(:each) do
      @host = create(:user, uid: '1234')
      @user = create(:user)
      login(@user)
      @loggedin = User.order(:id).last
      @party = create(:party, name: 'Test Party', user: @host, users: [@host, @loggedin])
    end

    it 'shows me the room name and room code on the page' do
      visit party_path

      expect(page).to have_content('Party Name')
      expect(page).to have_content('Party Code')
      within '#room-name' do
        expect(page).to have_content('Test Party')
      end
      within '#room-code' do
        expect(page).to have_content('a1b2c3')
      end
    end

    it 'has a button for me to leave the party' do
      visit party_path

      expect(page).to have_button("Bail Out")
      click_button('Bail Out')

      expect(current_path).to eq(root_path)
      expect(Party.last.users).to_not include(@loggedin)
    end
  end
end
