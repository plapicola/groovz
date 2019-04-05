class RemoveGenresTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :genres
  end
end
