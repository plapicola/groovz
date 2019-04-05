# frozen_string_literal: true

# Helper for stubbing omniauth OAuth responses
module OmniauthHelper
  def stub_spotify
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(
      provider: 'spotify',
      credentials: {
        'token' => ENV['SPOTIFY_TOKEN'],
        'refresh_token' => '654321',
        'expires_at' => 1_403_021_232,
        'expires' => true
      }
    )
  end
end
