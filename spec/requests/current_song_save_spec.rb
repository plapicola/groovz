require 'rails_helper'

describe 'Internal Player API' do
  context 'as user' do
    it 'i can check if a song isnt saved in my spotify account' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)
        VCR.use_cassette('requests/unsaved_song') do
          get '/api/v1/me/track_status?id=4VqPOruhp5EdPBeR92t6lQ'

          status = JSON.parse(response.body, symbolize_names: true)

          expect(status[:data][:attributes][:status]).to eq(false)
        end
    end

    it 'i can check if a song is saved in my spotify account' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)
        VCR.use_cassette('requests/saved_song') do
          get '/api/v1/me/track_status?id=4vnukzBCfcOHeBYp1N7dDz'

          status = JSON.parse(response.body, symbolize_names: true)

          expect(status[:data][:attributes][:status]).to eq(true)
        end
    end

    it 'can save a song for the user' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)

        VCR.use_cassette('requests/save_song') do
          get '/api/v1/me/save_track?id=75eW0q4UnnNT1W5A2nlibq&type=false'

          status = JSON.parse(response.body, symbolize_names: true)

          expect(status[:data][:attributes][:status]).to eq("Song Saved")
        end
    end

    it 'can remove a song for the user' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)

        VCR.use_cassette('requests/remove_song') do
          get '/api/v1/me/save_track?id=75eW0q4UnnNT1W5A2nlibq&type=true'

          status = JSON.parse(response.body, symbolize_names: true)
          expect(status[:data][:attributes][:status]).to eq("Song Removed")
        end
    end
  end
end
