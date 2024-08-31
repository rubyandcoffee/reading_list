class AddActiveToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :active, :boolean, default: true

    Rental.transaction do
      Rental.all.each do |rental|
        rental.update!(active: false) if rental.return_date.present?
      end
    end

    remove_column :rentals, :loan_date
    remove_column :rentals, :return_date
    remove_column :loaners, :week_duration
  end
end
