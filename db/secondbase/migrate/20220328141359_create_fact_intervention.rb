class CreateFactIntervention < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_interventions do |t|
      t.string :employee_id
      t.string :building_id
      t.string :battery_id
      t.string :column_id
      t.string :elevator_id
      t.datetime :startdate
      t.datetime :enddate
      t.string :result
      t.string :report
      t.string :status
    end
  end
end
