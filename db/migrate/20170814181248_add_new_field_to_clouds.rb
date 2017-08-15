class AddNewFieldToClouds < ActiveRecord::Migration[5.1]
  def change
    add_column :clouds, :number, :integer
  end
end
