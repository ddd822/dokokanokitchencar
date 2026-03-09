class AddTelephoneNumberToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :telephone_number, :string
  end
end
