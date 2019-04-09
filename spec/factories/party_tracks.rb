FactoryBot.define do
  factory :party_track do
    party
    spotify_id { "SPOTIFY:ID:12345" }
    img_url { "http://image.com/fake.png" }
    title { "Song Title" }
    artist { "Song Artist" }
  end
end
