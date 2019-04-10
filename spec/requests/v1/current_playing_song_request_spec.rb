require 'rails_helper'

RSpec.describe 'Current Song API', type: :request do
  context 'as a User' do
    it "I can get the current playing song information for my party" do
      user = create(:user)
      party = create(:party, users: [user])
      current_track = create(:party_track, party: party)


      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      get '/api/v1/me/currently_playing'

      current_song = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(current_song).to be_a Hash
      expect(current_song[:attributes]).to be_a Hash
      expect(current_song[:id]).to eq(current_track.id.to_s)
      expect(current_song[:attributes][:spotify_id]).to eq(current_track.spotify_id)
      expect(current_song[:attributes][:title]).to eq(current_track.title)
      expect(current_song[:attributes][:artist]).to eq(current_track.artist)
      expect(current_song[:attributes][:img_url]).to eq(current_track.img_url)
    end
  end
end
