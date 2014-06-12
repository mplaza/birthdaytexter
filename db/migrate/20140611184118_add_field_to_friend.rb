class AddFieldToFriend < ActiveRecord::Migration
  def change
  	add_column :friends, :daybirth, :integer
  	add_column :friends, :monthbirth, :integer
  end
end
