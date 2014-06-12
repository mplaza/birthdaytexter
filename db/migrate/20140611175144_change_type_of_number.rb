class ChangeTypeOfNumber < ActiveRecord::Migration
  def change
  	change_column :friends, :number, :bigint
  end
end
