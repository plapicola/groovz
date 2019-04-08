class AddPlaybackDeviceToParty < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :device_id, :string
  end
end
