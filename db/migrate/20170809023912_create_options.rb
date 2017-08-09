class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.string :op1
      t.string :op2
      t.integer :checked
      t.integer :value
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
