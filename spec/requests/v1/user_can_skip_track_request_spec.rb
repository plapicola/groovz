require 'rails_helper'

describe 'Skip Track API' do
  context 'as a user' do
    it 'can skip my currently song and play the next song on the playlist' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)
      VCR.use_cassette('requests/skip_track') do

        response = get '/api/v1/me/tracks/skip_track'
  
        expect(response).to eq(200)
      end
    end
  end
end
