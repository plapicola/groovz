FactoryBot.define do
  factory :user do
    uid { ENV['SPOTIFY_UID'] }
    token { ENV['SPOTIFY_TOKEN'] }
    refresh_token { ENV['SPOTIFY_REFRESH_TOKEN'] }
    expires_at { 1554852454 }
    expires { true }
    name { 'Tim' }
  end
end
