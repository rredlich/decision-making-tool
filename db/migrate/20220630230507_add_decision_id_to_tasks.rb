class AddDecisionIdToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :decision_id, :integer
  end
end
