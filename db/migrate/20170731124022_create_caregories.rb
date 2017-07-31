class CreateCaregories < ActiveRecord::Migration[5.1]
  def change
    create_table :caregories do |t|
      t.string :name
      t.references :node
      t.references :tree

      t.timestamps
    end
  end
end
