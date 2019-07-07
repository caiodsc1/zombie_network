require 'faker'

class TradesServiceHelper
  RESOURCES_POINTS = { water: 4, food: 3, medication: 2, ammunition: 1 }.freeze

  def self.generate_resources
    return Hash[[:water, :food, :medication, :ammunition].collect { |item| [item, Faker::Number.digit.to_i ] } ]
  end

  def self.generate_invalid_resources(resources)
    result = generate_resources
    while points_for(result) == points_for(resources)
      result = generate_resources
    end
    return result
  end

  def self.points_for(resource)
    resource.inject(0) { |total, (resource, quantity)| total + RESOURCES_POINTS[resource] * quantity }
  end

  def self.get_equivalent_resources(resources)
    valid = {}
    points = points_for(resources)
    random = rand(0..points/4)
    valid[:water] = random
    points -= random * 4
    random = rand(0..points/3)
    valid[:food] = random
    points -= random * 3
    random = rand(0..points/2)
    valid[:medication] = random
    points -= random * 2
    valid[:ammunition] = points
    return valid
  end
end