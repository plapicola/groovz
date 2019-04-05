class ChangeUsersColumnNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :avg_mode, :mode
    rename_column :users, :avg_acousticness, :acousticness
    rename_column :users, :avg_danceability, :danceability
    rename_column :users, :avg_energy, :energy
    rename_column :users, :avg_valence, :valence
    rename_column :users, :avg_tempo, :tempo
  end
end
