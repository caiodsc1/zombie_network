class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.references :survivor, foreign_key: true
      t.integer :water, default: 0
      t.integer :food, default: 0
      t.integer :medication, default: 0
      t.integer :ammunition, default: 0

      t.timestamps
    end
  end
end
