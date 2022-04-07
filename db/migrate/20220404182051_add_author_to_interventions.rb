class AddAuthorToInterventions < ActiveRecord::Migration[5.2]
  def change
    add_reference :interventions, :author, foreign_key: { to_table: :employees }
  end
end
