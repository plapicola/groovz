class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.references :user, foreign_key: true
      t.string :artist_name

      t.timestamps
    end
  end
end
