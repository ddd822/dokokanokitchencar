class CreateRegularHolidays < ActiveRecord::Migration[6.1]
  def change
    create_table :regular_holidays do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :weekday, null: false, foreign_key: true

      t.timestamps
    end
    add_index :regular_holidays, [:shop_id, :weekday_id], unique: true
  end
end
