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
      it 'returns data on the status for the song and the user' do
        user = create(:user)
        service = SpotifyService.new(user)

        response = service.user_saved?("75eW0q4UnnNT1W5A2nlibq")

        expect(response.first).to eq(true)

        response = service.user_saved?("15eW0q4UnnNT1W5A3nlibq") #changed key to random song

        expect(response.first).to eq(false)
      end
    end

    describe 'save track' do
      it 'will call to spotifys api to save the song to a user' do
        user = create(:user)
        service = SpotifyService.new(user)

        response = service.save_track("15eW0q4UnnNT1W5A3nlibq")
        binding.pry

        expect(response.first).to eq(true)
      end
    end

    describe 'remove track' do
      it 'will call to spotifys api to remove the track from a user' do
        user = create(:user)
        service = SpotifyService.new(user)

        response = service.remove_track("15eW0q4UnnNT1W5A3nlibq")
        binding.pry

        expect(response.first).to eq(true)
      end
    end
  end
end
