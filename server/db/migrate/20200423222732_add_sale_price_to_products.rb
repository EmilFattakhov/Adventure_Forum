class AddSalePriceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :sale_price, :float
  end
end
