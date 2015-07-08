class CreateFacebookNetworks < ActiveRecord::Migration
  def change
    create_table :facebook_networks do |t|
      t.integer :user_id
      t.string :access_token
      t.string :facebook_id

      t.timestamps null: false
    end

    add_index :facebook_networks, :user_id
  end
end
