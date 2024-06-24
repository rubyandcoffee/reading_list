class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.references :book, null: false, foreign_key: true
      t.string :borrowed_from
      t.datetime :borrowed_date
      t.datetime :returned_date

      t.timestamps
    end
  end
end
