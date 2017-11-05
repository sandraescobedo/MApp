class AddAirportsToFlight < ActiveRecord::Migration[5.1]
  def change
    change_table :flights do |t|
      t.references :origin_airport
      t.references :destination_airport
    end
  end
end
