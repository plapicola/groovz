require 'rails_helper'

RSpec.describe Track, type: :model do

  describe 'class methods' do
    describe '#user_saved?' do
      it 'returns boolean on if user has saved a track or not already' do
        user = create(:user)
        response = Track.user_saved?("75eW0q4UnnNT1W5A2nlibq", user)

        expect(response).to eq(true)
      end
    end
  end
end
