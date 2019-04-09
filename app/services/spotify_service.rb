# frozen_string_literal: true

class SpotifyService
  def initialize(user)
    @user = user
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_json(url)
    faraday_response = response(url).body
    JSON.parse(faraday_response, symbolize_names: true) unless faraday_response.empty?
  end

  def post_response(url)
    pr = conn.post(url) do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.body = { 'name' => "GroovzApp Playlist" }.to_json
    end
    JSON.parse(pr.body, symbolize_names: true)
  end

  def response(url)
    conn.get(url)
  end

  def conn
    user_service.refresh_token if Time.at(@user.expires_at) < Time.now
    Faraday.new(url: 'https://api.spotify.com') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{@user.token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def user_service
    UserSpotifyService.new(@user)
  end
end
