require 'rails_helper'

describe 'Internal Player API' do
  contex 'as user' do
    it 'i can check if a song is saved in my spotify account' do
      user = create(:user)
      expect_any_instance_of(ApplicationController).to recieve(:current_user)
        .and_return(user)

        get 'api/v1/me/track_status?id=75eW0q4UnnNT1W5A2nlibq'

        status = JSON.parse(response.body, symbolize_names: true)
        binding.pry
        expect(status).to eq(true)
    end
  end
end
