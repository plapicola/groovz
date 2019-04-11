require 'rails_helper'

feature 'playback control', :js do
  context 'as a host' do
    it 'allows me to control playback' do
      @host = create(:user)
      login(@host)
      VCR.use_cassette('features/playback_functions') do
        visit root_path

        click_button 'Create Party'

        click_button 'Start Party'

        click_button 'Start Partying'

        expect(page.find_all('.icon').count).to eq(3)

        expect(page).to have_css("img[src*='pause-button.png']")

        page.find('#pause-play').click

        expect(page).to have_css("img[src*='play-button.png']")
      end
    end
  end
end
