require 'rails_helper'

RSpec.describe Track do
  before :each do
    track_info = {
      id: 1,
      mode: 0.1,
      acousticness: 0.2,
      danceability: 0.3,
      energy: 0.4,
      valence: 0.5,
      tempo: 120.0
    }
    @track = Track.new(track_info)
  end

  it 'exists' do
    expect(@track).to be_a(Track)
  end

  it 'has attributes' do
    expect(@track.id).to eq(1)
    expect(@track.mode).to eq(0.1)
    expect(@track.acousticness).to eq(0.2)
    expect(@track.danceability).to eq(0.3)
    expect(@track.energy).to eq(0.4)
    expect(@track.valence).to eq(0.5)
    expect(@track.tempo).to eq(120.0)
  end
end
