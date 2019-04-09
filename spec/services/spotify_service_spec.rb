# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpotifyService do
  it 'exists' do
    user = create(:user)
    service = SpotifyService.new(user)

    expect(service).to be_a SpotifyService
  end

  describe 'instance methods' do
  end
end
