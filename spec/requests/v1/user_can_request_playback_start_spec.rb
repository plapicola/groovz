require 'rails_helper'

RSpec.describe 'Playback API' do
  describe 'as a host' do
    it 'I can initiate spotify playback' do
      user = create(:user)
      party = create(:party,
        playlist_id: '4ZenWelYqdG7lVhcDerX9D',
        device_id: '6f5333c011e9913b7ea319fdcc9f144e7e4329f2'
        user: user
        users: [:user]
      )

      get '/api/v1/me/start_playback'

      expect(party.current_song.title).to eq('Silver Bullet')
    end
  end
end
