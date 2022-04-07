class ChangeLatAndLngToStringInAddresses < ActiveRecord::Migration[5.2]
  def change
    change_column :addresses, :lat, :string
    change_column :addresses, :lng, :string
  end
end
