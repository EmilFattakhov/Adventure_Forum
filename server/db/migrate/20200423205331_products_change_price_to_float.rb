class ProductsChangePriceToFloat < ActiveRecord::Migration[6.0]
  def change
    # https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-change_column
    change_column :products, :price, :float
  end
end
