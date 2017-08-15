class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.string :name
      t.string :op1
      t.string :op2
      t.string :op3
      t.string :op4
      t.string :op5
      t.string :op6
      t.string :op7
      t.string :op8
      t.string :op9
      t.string :op10
      t.string :op11
      t.string :op12
      t.string :op13
      t.string :op14
      t.string :op15
      t.string :op16
      t.string :op17
      t.string :op18
      t.string :op19
      t.string :op20
      t.string :op21
      t.string :op22
      t.string :op23
      t.string :op24
      t.string :op25
      t.integer :value1
      t.integer :value2
      t.integer :value3
      t.integer :value4
      t.integer :value5
      t.integer :value6
      t.integer :value7
      t.integer :value8
      t.integer :value9
      t.integer :value10
      t.integer :value11
      t.integer :value12
      t.integer :value13
      t.integer :value14
      t.integer :value15
      t.integer :value16
      t.integer :value17
      t.integer :value18
      t.integer :value19
      t.integer :value20
      t.integer :value21
      t.integer :value22
      t.integer :value23
      t.integer :value24
      t.integer :value25
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
