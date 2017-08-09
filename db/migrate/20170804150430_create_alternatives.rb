class CreateAlternatives < ActiveRecord::Migration[5.1]
  def change
    create_table :alternatives do |t|
      t.string :name
      t.float :weight
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
