require 'rails_helper'

RSpec.describe TrackStatus, type: :model do
  describe 'class methods' do
    describe '#user_saved?' do
      it 'returns boolean on if user has saved a track or not already' do
        user = create(:user)
        VCR.use_cassette('models/track_saved') do
          response = TrackStatus.user_saved?({id: "4vnukzBCfcOHeBYp1N7dDz"}, user)

          expect(response.id).to eq("4vnukzBCfcOHeBYp1N7dDz")
          expect(response.status).to eq(true)

          response = TrackStatus.user_saved?({id: "15eW0q4UnnNT1W5A2nlibq"}, user) #song id changed to random song

          expect(response.id).to eq("15eW0q4UnnNT1W5A2nlibq")
          expect(response.status).to eq(false)
        end
      end
    end

    describe '#save_or_remove' do
      it 'sets a message attribute for song removed or song saved' do
        user = create(:user)

        VCR.use_cassette('models/save_or_remove_song') do
          response = TrackStatus.save_or_remove({id: "75eW0q4UnnNT1W5A2nlibq", type: "false"}, user)

          expect(response.status).to eq("Song Saved")

          response = TrackStatus.save_or_remove({id: "75eW0q4UnnNT1W5A2nlibq", type: "true"}, user)

          expect(response.status).to eq("Song Removed")
        end
      end
    end
  end
end
