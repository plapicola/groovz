require 'rails_helper'

describe 'Playback API' do
  context 'as a User' do
    xit 'I can toggle playback state' do
      user = create(:user)
      create(:party, user: user, users: [user])

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)

      get 'api/v1/me/playback/toggle'

      expect(response.status).to eq(200)
    end
  end
end
