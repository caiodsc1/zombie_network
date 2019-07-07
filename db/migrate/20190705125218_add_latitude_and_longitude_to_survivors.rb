class AddLatitudeAndLongitudeToSurvivors < ActiveRecord::Migration[5.2]
  def change
    add_column :survivors, :latitude, :decimal, precision: 10, scale: 6, default: 0, null: false
    add_column :survivors, :longitude, :decimal, precision: 10, scale: 6, default: 0, null: false
  end

  # TODO
  # add_index :users, [:latitude, :longitude]
end
