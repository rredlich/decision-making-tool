class CreateTask < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :name
      t.integer :votes
    end
  end
end
