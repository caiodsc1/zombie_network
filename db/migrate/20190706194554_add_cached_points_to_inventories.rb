class AddCachedPointsToInventories < ActiveRecord::Migration[5.2]
  def change
    add_column :inventories, :cached_points, :integer, default: 0
  end
end
