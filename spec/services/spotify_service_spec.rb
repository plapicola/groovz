require 'rails_helper'

RSpec.describe SpotifyService do
  it 'exists' do
    user = create(:user)
    service = SpotifyService.new(user)

    expect(service).to be_a SpotifyService
  end

  describe 'instance methods' do
    describe '.devices' do
      it 'returns a list of available devices for the user' do
        user = create(:user)
        service = SpotifyService.new(user)

        devices = service.devices

        expect(devices).to be_a Array
        expect(devices[0]).to have_key :id
        expect(devices[0]).to have_key :name
      end
    end

    describe 'user_saved?' do
      user = create(:user)
      service = SpotifyService.new(user)

      response = service.user_saved?("75eW0q4UnnNT1W5A2nlibq")

      expect(response).to eq(true)
    end
  end
end
