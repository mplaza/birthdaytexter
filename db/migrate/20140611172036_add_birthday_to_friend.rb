class AddBirthdayToFriend < ActiveRecord::Migration
  def change
  	add_column :friends, :birthday, :date
  end
end
