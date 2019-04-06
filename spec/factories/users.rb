FactoryBot.define do
  factory :user do
    uid { "MyString" }
    token { ENV['SPOTIFY_TOKEN'] }
    refresh_token { ENV['SPOTIFY_REFRESH_TOKEN'] }
    expires_at { 1 }
    expires { false }
  end
end
