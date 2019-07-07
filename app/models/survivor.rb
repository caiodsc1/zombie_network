class Survivor < ApplicationRecord

  MAX_INFECTION = 3

  include Reportable

  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  has_one :inventory, dependent: :destroy
  accepts_nested_attributes_for :inventory
  validates_presence_of :name, :age, :gender, :latitude, :longitude, :inventory

  delegate :water, :food, :medication, :ammunition, to: :inventory

  enum gender: [:male, :female]

  scope :infected, lambda {
    where('times_reported >= ?', MAX_INFECTION)
  }

  scope :not_infected, lambda {
    where('times_reported < ?', MAX_INFECTION)
  }

  def is_infected?
    times_reported >= MAX_INFECTION
  end

  def has_these_resources?(resources)
    resources.each do |resource, required|
      return false if (inventory[resource] < required or required < 0)
    end
    return true
  end

  def reports_infection_of(suspect)
    if is_infected?
      errors.add(:base, message: "You can't tag another survivor as infected because you are infected!") and return false
    else
      if suspect.already_reported_by?(self)
        errors.add(:base, message: 'Survivor already tagged as infected by you!') and return false
      else
        suspect.add_report_from(self) and return true
      end
    end
  end

  def with_inventory
    JSON.parse(self.to_json(include: { inventory: { only: [:water, :food, :medication, :ammunition] } }))
  end
end
