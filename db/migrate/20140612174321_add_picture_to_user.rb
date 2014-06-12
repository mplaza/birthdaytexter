class AddPictureToUser < ActiveRecord::Migration
  def change
  	add_column :users, :profile_picture_url, :string
  	add_column :users, :token_expiry, :string
  end
end
