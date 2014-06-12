class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.integer :number
      t.string :email
      t.string :message

      t.timestamps
    end
  end
end
