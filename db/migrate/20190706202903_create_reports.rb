class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :reporter, index: true
      t.references :reported, index: true
      t.string :reporter_type
      t.string :reported_type

      t.timestamps
    end
  end
end
