require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of :code }
    it { should validate_uniqueness_of :code }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should have_many :party_tracks }
    it { should have_many :users }
    it { should belong_to :user }
  end

  describe 'class methods' do
    it 'generate_party' do
      user = create(:user)
      party_count = Party.all.count
      expected_party_count = party_count + 1

      Party.generate_party(user.id)
      expect(Party.all.count).to eq(expected_party_count)
    end

    it 'get_party_tastes' do
      user_1 = create(:user, tempo: 60.0,
                             mode: 0.0,
                             valence: 0.0,
                             energy: 0.0,
                             danceability: 0.0,
                             acousticness: 0.0
                           )

      user_2 = create(:user, tempo: 120.0,
                             mode: 1.0,
                             valence: 1.0,
                             energy: 1.0,
                             danceability: 1.0,
                             acousticness: 1.0,
                             uid: '126311576'
                           )
      party = Party.create(user: user_1, users: [user_1, user_2], code: 'sample')
      party_with_tastes = Party.get_party_tastes(party)

      expect(party_with_tastes.avg_mode).to eq(0.50)
      expect(party_with_tastes.avg_valence).to eq(0.50)
      expect(party_with_tastes.avg_dance).to eq(0.50)
      expect(party_with_tastes.avg_acoust).to eq(0.50)
      expect(party_with_tastes.avg_energy).to eq(0.50)
      expect(party_with_tastes.avg_tempo).to eq(90.0)
    end
  end

  describe 'instance methods' do
    it 'new_song?' do
      
    end
  end
end
