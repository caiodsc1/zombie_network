module Reportable
  extend ActiveSupport::Concern

  included do
    has_many :infection_reports, as: :reported, class_name: 'Report', dependent: :delete_all
  end

  def already_reported_by?(reporter)
    infection_reports.where(reporter: reporter).exists?
  end
  
  def add_report_from(reporter)
    Report.create(reporter: reporter, reported: self)
  end
end