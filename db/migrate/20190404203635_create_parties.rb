class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.references :user, foreign_key: true
      t.string :playlist_id
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
