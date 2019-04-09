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
        end
      end
    end
  end
end
