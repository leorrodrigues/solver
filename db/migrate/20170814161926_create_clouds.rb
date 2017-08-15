class CreateClouds < ActiveRecord::Migration[5.1]
  def change
    create_table :clouds do |t|
      t.integer :vm
      t.integer :cpu
      t.integer :ram
      t.integer :storage

      t.timestamps
    end
  end
end
