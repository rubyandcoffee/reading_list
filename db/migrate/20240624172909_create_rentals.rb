class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.references :book, null: false, foreign_key: true
      t.references :loaner, null: false, foreign_key: true
      t.datetime :loan_date
      t.datetime :return_date

      t.timestamps
    end
  end
end
