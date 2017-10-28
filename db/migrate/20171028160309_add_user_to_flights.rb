class AddUserToFlights < ActiveRecord::Migration[5.1]
  def change
    change_table :flights do |t|
      t.references :user
    end
  end
end
