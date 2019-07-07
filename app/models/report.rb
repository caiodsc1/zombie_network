class Report < ApplicationRecord
  validate :check_report

  belongs_to :reporter, polymorphic: true, dependent: :destroy
  belongs_to :reported, polymorphic: true, counter_cache: :times_reported, dependent: :destroy

  def check_report
    if reporter_type == reported_type
      errors.add(:base, message: "Reporter can't report himself!") if reporter_id == reported_id
    end
  end
end
