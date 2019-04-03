class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :token
      t.string :refresh_token
      t.integer :expires_at
      t.boolean :expires

      t.timestamps
    end
  end
end
