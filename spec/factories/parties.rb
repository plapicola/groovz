FactoryBot.define do
  factory :party do
    user
    name { "MyString" }
    code { "a1b2c3" }
  end
end
