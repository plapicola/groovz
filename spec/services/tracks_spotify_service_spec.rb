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
  end
end
