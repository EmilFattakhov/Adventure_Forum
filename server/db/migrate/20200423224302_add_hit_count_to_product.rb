class AddHitCountToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :hit_count, :integer
  end
end
