require 'rails_helper'

describe 'party show page' do
  context 'a user who has started a party' do
    before(:each) do
      @host = create(:user)
      @user = create(:user, uid: "123456")
      login(@host)
      @loggedin = User.find(@host.id)
      @party = create(:party, name: 'Test Party', user: @host, users: [@host, @loggedin])
    end

    it 'shows me the room name and room code on the page' do
      visit host_party_path

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
      visit host_party_path

      expect(page).to have_button("Shut It Down")
      click_button('Shut It Down')

      expect(current_path).to eq(root_path)
      expect(Party.count).to eq(0)
    end
  end
end
