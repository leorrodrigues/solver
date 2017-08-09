class CreateAhps < ActiveRecord::Migration[5.1]
  def change
    create_table :ahps do |t|

      t.timestamps
    end
  end
end
