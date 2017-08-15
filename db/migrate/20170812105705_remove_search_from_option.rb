class RemoveSearchFromOption < ActiveRecord::Migration[5.1]
  def change
    remove_reference :options, :search, foreign_key: true
  end
end
