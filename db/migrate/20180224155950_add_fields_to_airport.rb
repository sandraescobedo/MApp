class AddFieldsToAirport < ActiveRecord::Migration[5.1]
  def change
    add_column :airports, :name, :string
    add_column :airports, :city, :string
  end
end
