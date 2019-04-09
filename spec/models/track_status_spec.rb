require 'rails_helper'

RSpec.describe TrackStatus, type: :model do
  describe 'class methods' do
    describe '#user_saved?' do
      it 'returns boolean on if user has saved a track or not already' do
        user = create(:user)
        response = TrackStatus.user_saved?("75eW0q4UnnNT1W5A2nlibq", user)

        expect(response.id).to eq("75eW0q4UnnNT1W5A2nlibq")
        expect(response.status).to eq(true)

        response = TrackStatus.user_saved?("15eW0q4UnnNT1W5A2nlibq", user) #song id changed to random song

        expect(response.id).to eq("15eW0q4UnnNT1W5A2nlibq")
        expect(response.status).to eq(false)
      end
    end
  end
end
