class AddSurvivorsToReports < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :reports, :survivors, column: :reporter_id, on_delete: :cascade
    add_foreign_key :reports, :survivors, column: :reported_id, on_delete: :cascade
  end
end
