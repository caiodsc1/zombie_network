class AddReportedCountToSurvivors < ActiveRecord::Migration[5.2]
  def change
    add_column :survivors, :times_reported, :integer, default: 0
  end
end
