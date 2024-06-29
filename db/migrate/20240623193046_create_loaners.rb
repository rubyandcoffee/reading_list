class CreateLoaners < ActiveRecord::Migration[7.0]
  def change
    create_table :loaners do |t|
      t.string :name
      t.integer :week_duration

      t.timestamps
    end
  end
end
