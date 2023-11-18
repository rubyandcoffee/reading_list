class AddGenderAndNationalityToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :gender, :string
    add_column :authors, :nationality, :string
  end
end
