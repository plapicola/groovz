require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :uid}
    it { should validate_uniqueness_of :uid}
  end

  describe 'relationships' do
    it { should have_many :artists}
  end

  describe 'instance methods' do
    it 'update_musical_taste' do
      user = create(:user)

      VCR.use_cassette('update_musical_taste') do
        expect(user.artists.count).to eq(0)
        expect(user.mode).to eq(nil)
        expect(user.acousticness).to eq(nil)
        expect(user.valence).to eq(nil)
        expect(user.danceability).to eq(nil)
        expect(user.energy).to eq(nil)
        expect(user.tempo).to eq(nil)

        user.update_musical_taste

        expect(user.artists.count).to eq(10)
        expect(user.mode).to_not eq(nil)
        expect(user.acousticness).to_not eq(nil)
        expect(user.valence).to_not eq(nil)
        expect(user.danceability).to_not eq(nil)
        expect(user.energy).to_not eq(nil)
        expect(user.tempo).to_not eq(nil)
      end
    end
  end
end
