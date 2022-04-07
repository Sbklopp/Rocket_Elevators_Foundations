class AddColumnsToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_reference :interventions, :customer, foreign_key: true
    add_reference :interventions, :building, foreign_key: true
    add_reference :interventions, :battery, foreign_key: true
    add_reference :interventions, :column, foreign_key: true
    add_reference :interventions, :elevator, foreign_key: true
    add_reference :interventions, :employee, foreign_key: true
    add_column :interventions, :start_date, :datetime
    add_column :interventions, :end_date, :datetime
    add_column :interventions, :result, :string
    add_column :interventions, :report, :string
    add_column :interventions, :status, :string
  end
end
