class ChanangeShopColumnNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :shops, :name, :firstname
    rename_column :shops, :surname, :lastname
    rename_column :shops, :social_reason, :company_name
  end
end
