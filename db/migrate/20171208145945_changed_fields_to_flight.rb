class ChangedFieldsToFlight < ActiveRecord::Migration[5.1]
  def up
    rename_column :flights, :origin_airport_id, :departured_id
    rename_column :flights, :destination_airport_id, :arrived_id
  end
  def down
    rename_column :flights, :departured_id, :origin_airport_id
    rename_column :flights, :arrived_id, :destination_airport_id
  end
end
