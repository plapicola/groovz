class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avg_mode, :float
    add_column :users, :avg_acousticness, :float
    add_column :users, :avg_danceability, :float
    add_column :users, :avg_energy, :float
    add_column :users, :avg_valence, :float
    add_column :users, :avg_tempo, :float
  end
end
