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
      user = create(:user)
      party = Party.create(user: user, users: [user], code: 'code')
      expect(party.party_tracks).to eq([])
      VCR.use_cassette('new_song? with new song playing') do
        expect(party.new_song?).to eq(true)
        expect(party.party_tracks.count).to eq(1)
        expect(party.new_song?).to eq(false)
      end
    end

    it 'current_song' do
        user = create(:user)
        party = Party.create(user: user, users: [user], code: 'code')
        party.party_tracks.create(artist: 'Queen',
                                  spotify_id: '4u7EnebtmKWzUH433cf5Qv',
                                  title: 'Bohemian Rhapsody - Remastered 2011',
                                  img_url: 'https://i.scdn.co/image/beae4292c3214147a7201ef48f855b4ed40ff84e'
                                )

        expect(party.current_song).to eq(party.party_tracks[0])
    end

    it 'setup_playlist' do
      user = create(:user)
      party = Party.create(user: user, users: [user], code: 'code')
      expect(party.playlist_id).to eq(nil)
      VCR.use_cassette('make_playlist') do
        party.setup_playlist
        expect(party.playlist_id).to_not eq(nil)
      end
    end

    it 'repopulate_playlist' do
      user = create(:user, tempo: 60.0,
                            mode: 0.0,
                            valence: 0.0,
                            energy: 0.0,
                            danceability: 0.0,
                            acousticness: 0.0
                          )
      Artist.create(user_id: user.id, spotify_id: '0TnOYISbd1XYRBk9myaseg')
      party = create(:party, user: user, users: [user], code: 'code', playlist_id: '54FMH2qVtFm85IAI37mE5I')
      VCR.use_cassette('repopulate_playlist') do
        response = party.repopulate_playlist
        expect(response.status).to eq(201)
      end
    end

    it 'update_playlist_name' do
      user = create(:user)
      party = create(:party, user: user, users: [user], code: 'code', playlist_id: '54FMH2qVtFm85IAI37mE5I')
      VCR.use_cassette('update_playlist_name') do
        response = party.update_playlist_name
        expect(response.status).to eq(200)
      end
    end
  end
end
