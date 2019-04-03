module OmniauthHelper
  def stub_spotify
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(
      provider: "spotify",
      credentials: {
         "token" => "123456",
         "refresh_token" => "654321",
         "expires_at" => 1403021232,
         "expires" => true
      }
    )
  end
end
