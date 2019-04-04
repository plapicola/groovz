FactoryBot.define do
  factory :user do
    uid { "MyString" }
    token { "MyString" }
    refresh_token { "MyString" }
    expires_at { 1 }
    expires { false }
  end
end
