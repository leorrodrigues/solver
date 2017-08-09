class CreateNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes do |t|
      t.string :name
      t.float :weight
      t.integer :hight
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
