class AddUserToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :user
  end
end
