class AddLatAndLngToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :addresses, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
