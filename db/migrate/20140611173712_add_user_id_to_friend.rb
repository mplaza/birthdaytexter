class AddUserIdToFriend < ActiveRecord::Migration
  def change
  	add_column :friends, :user_id, :integer
  end
end
