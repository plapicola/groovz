class AddPlayingToParty < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :playing, :boolean
  end
end
