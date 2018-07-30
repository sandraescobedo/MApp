class AddDateToFlight < ActiveRecord::Migration[5.1]
  def change
    add_column :flights, :departured_date, :date
  end
end
