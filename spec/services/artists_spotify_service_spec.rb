require 'rails_helper'

RSpec.describe ArtistsSpotifyService do
  it 'exists' do
    user = create(:user)
    service = ArtistsSpotifyService.new(user)

    expect(service).to be_a ArtistsSpotifyService
  end

  describe 'instance methods' do
    describe '.add_artists' do
      it 'requests the top 10 artists for the user' do
       user = create(:user)
       service = ArtistsSpotifyService.new(user)

       VCR.use_cassette('service/artists') do
         artists = service.add_artists(user)
       end

       expect(Artist.count).to eq(10)
      end
    end
  end
end
