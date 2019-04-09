require 'rails_helper'

RSpec.describe UserSpotifyService do
  it 'exists' do
    user = create(:user)
    service = UserSpotifyService.new(user)

    expect(service).to be_a(UserSpotifyService)
  end

  describe 'instance methods' do
    describe '.devices' do
      it 'returns a list of available devices for the user' do
        VCR.use_cassette('requests/devices') do
          user = create(:user)
          service = UserSpotifyService.new(user)

          devices = service.devices

          expect(devices).to be_a Array
          expect(devices[0]).to have_key :id
          expect(devices[0]).to have_key :name
        end
      end
    end

    describe '.refresh_token' do
      it 'returns an access token and a new refresh token if one is sent and saves them into the database' do
        VCR.use_cassette('requests/tokens') do

          user = create(:user)
          service = UserSpotifyService.new(user)
          old_token = user.token
          response = service.refresh_token

          expect(response).to eq(true)
          expect(user.token).to_not eq(old_token)
        end
      end
    end
  end
end
