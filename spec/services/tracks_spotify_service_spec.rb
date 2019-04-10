# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TracksSpotifyService do
  it 'exists' do
    user = create(:user)
    service = TracksSpotifyService.new(user)

    expect(service).to be_a(TracksSpotifyService)
  end

  describe 'instance methods' do
    describe '#get_tracks' do
      it 'gets a users top tracks and creates a track object with their values' do
        VCR.use_cassette('requests/tracks') do
          user = create(:user)
          service = TracksSpotifyService.new(user)

          response = service.get_tracks

          expect(response.count).to eq(50)
          expect(response[0].acousticness).to be_a(Float)
          expect(response[0].danceability).to be_a(Float)
          expect(response[0].energy).to be_a(Float)
          expect(response[0].id).to be_a(String)
          expect(response[0].mode).to be_a(Integer)
          expect(response[0].tempo).to be_a(Float)
          expect(response[0].valence).to be_a(Float)
        end
      end
    end
    describe 'user_saved?' do
      it 'returns data on the status for the song and the user' do
        user = create(:user)
        service = TracksSpotifyService.new(user)

        VCR.use_cassette('services/user_saved') do
          response = service.user_saved?("2eTHgWvYYunxgqYKqNOuZD")

          expect(response.first).to eq(true)

          response = service.user_saved?("5ygDXis42ncn6kYG14lEVG") #changed key to random song

          expect(response.first).to eq(false)
        end
      end
    end

    describe 'save track' do
      it 'will call to spotifys api to save the song to a user' do
        user = create(:user)
        service = TracksSpotifyService.new(user)

        VCR.use_cassette('services/save_track') do
          response = service.save_track("4VqPOruhp5EdPBeR92t6lQ")

          expect(response).to eq('Song Saved')
        end
      end
    end

    describe 'remove track' do
      it 'will call to spotifys api to remove the track from a user' do
        user = create(:user)
        service = TracksSpotifyService.new(user)
        VCR.use_cassette('services/remove_track') do
          response = service.remove_track("4VqPOruhp5EdPBeR92t6lQ")

          expect(response).to eq('Song Removed')
        end
      end
    end
  end
end
