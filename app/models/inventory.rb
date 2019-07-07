class Inventory < ApplicationRecord
  belongs_to :survivor
  validates_presence_of :water, :food, :medication, :ammunition, default: 0
  validates_numericality_of :water, :food, :medication, :ammunition, only_integer: true

  before_save do
    self.cached_points = inventory_points
  end

  def inventory_points
    return water * 4 + food * 3 + medication * 2 + ammunition
  end
end
