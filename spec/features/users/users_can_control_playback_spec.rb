require 'rails_helper'

feature 'playback control', :js do
  context 'as a host' do
    it 'allows me to control playback' do
      @host = create(:user)
      @party = create(:party,
                      user: @host,
                      users: [@host],
                      playlist_id: '54DrBchFJNDXFyxRY3ku3e',
                      device_id: '4c3c5c83a082baf4255e54cec7f9b61b595be57c')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@host)
      VCR.use_cassette('features/playback_functions') do
        visit host_party_path

        click_button 'Start Partying'

        expect(page.find_all('.icon').count).to eq(3)
        page.find('#pause-play-button').click

        expect(page).to have_css("img[src*='pause-button.png']")

        page.find('#pause-play-button').click

        expect(page).to have_css("img[src*='play-button.png']")
      end
    end
  end
end
