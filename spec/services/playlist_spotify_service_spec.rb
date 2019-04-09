require 'rails_helper'

RSpec.describe PlaylistSpotifyService do
  before :each do
    @user = create(:user)
    @service = PlaylistSpotifyService.new(@user)
  end

  it 'exists' do
    expect(@service).to be_a PlaylistSpotifyService
  end

  describe 'instance methods' do
    describe 'current_song' do
      it 'returns the current song being played for the user' do
        song = VCR.use_cassette('spec/current_song') do
          @service.current_song
        end

        expect(song).to be_a Hash
        expect(song).to have_key :name
        expect(song).to have_key :artists
        expect(song[:album][:artists][0]).to have_key :name
        expect(song[:album]).to have_key :images
      end
    end
  end
end
