require 'rails_helper'

describe 'Internal Player API' do
  context 'as user' do
    it 'i can check if a song is saved in my spotify account' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)

        get '/api/v1/me/track_status?id=75eW0q4UnnNT1W5A2nlibq'

        status = JSON.parse(response.body, symbolize_names: true)

        expect(status[:data][:attributes][:status]).to eq(true)
    end

    it 'can save the song that is currently playing' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)

        get '/api/v1/me/tracks?ids=75eW0q4UnnNT1W5A2nlibq&type=true'

        status = JSON.parse(response.body, symbolize_names: true)

        expect(response[:data][:attributes][:status]).to eq("Song Saved")
    end
  end
end
