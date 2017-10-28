class CreateAirports < ActiveRecord::Migration[5.1]
  def change
    create_table :airports do |t|
      t.string :iata_code
      t.string :address

      t.timestamps
    end
  end
end
