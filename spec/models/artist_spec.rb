require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { should validate_presence_of :spotify_id }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'class methods' do
    it 'get_common_artists' do
      user_1 = create(:user)
      user_2 = create(:user, uid: "2")
      user_3 = create(:user, uid: "3")
      user_4 = create(:user, uid: "4")

      user_1.artists.create(spotify_id: '1')
      user_2.artists.create(spotify_id: '1')
      user_3.artists.create(spotify_id: '1')
      user_4.artists.create(spotify_id: '3')
      user_1.artists.create(spotify_id: '3')
      user_2.artists.create(spotify_id: '2')

      party = create(:party, user: user_1, users: [user_1, user_2, user_3, user_4])

      expect(Artist.get_common_artists(party)).to eq('1,3,2')
    end
  end
end
