class CreateDecision < ActiveRecord::Migration[7.0]
  def change
    create_table :decisions do |t|
      t.string :hash_id
      t.timestamps
    end
  end
end
