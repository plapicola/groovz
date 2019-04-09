require 'rails_helper'

describe 'Internal Player API' do
  context 'as a user' do
    it 'I can request my currently available devices' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)
      VCR.use_cassette('requests/devices') do
        get '/api/v1/me/available_devices'

        devices = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(devices.length).to eq(2)
        expect(devices[0]).to be_a Hash
        expect(devices[0][:id]).to eq("1c98de8059bd26890c14444a92048b4f6aaec837")
        expect(devices[0][:attributes][:name]).to eq("DESKTOP-PHC270L")
      end
    end
  end
end
