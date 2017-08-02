class CreateAlternatives < ActiveRecord::Migration[5.1]
  def change
    create_table :alternatives do |t|
      t.string :name
      t.float :weight

      t.timestamps
    end
  end
end
