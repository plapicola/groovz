class CreatePartyTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :party_tracks do |t|
      t.string :spotify_id
      t.string :img_url
      t.string :title
      t.string :artist
      t.references :party, foreign_key: true

      t.timestamps
    end
  end
end
