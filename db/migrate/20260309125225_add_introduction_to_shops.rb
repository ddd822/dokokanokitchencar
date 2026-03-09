class AddIntroductionToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :introduction, :string
  end
end
