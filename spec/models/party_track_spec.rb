require 'rails_helper'

RSpec.describe PartyTrack, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :artist }
    it { should validate_presence_of :spotify_id }
  end

  describe 'relationships' do
    it { should belong_to :party }
  end
end
