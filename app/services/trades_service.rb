class TradesService
  attr_accessor :response

  RESOURCES_POINTS = {
    water: 4,
    food: 3,
    medication: 2,
    ammunition: 1
  }.with_indifferent_access

  def initialize(survivor_one, survivor_two, resources_one, resources_two)
    @survivor_one = survivor_one
    @survivor_two = survivor_two
    @resources_one = resources_one
    @resources_two = resources_two
  end

  def perform
    Survivor.transaction do
      check_survivors
      check_resources
      check_resources_points
      trade_resources and return true
    end
  rescue Exception => error
    @response = { status: :error, message: error.message }.as_json and return false
  end

  def trade_resources
    @resources_one.each do |resource, quantity|
      @survivor_one.inventory.decrement(resource, quantity)
      @survivor_two.inventory.increment(resource, quantity)
    end

    @resources_two.each do |resource, quantity|
      @survivor_one.inventory.increment(resource, quantity)
      @survivor_two.inventory.decrement(resource, quantity)
    end

    @survivor_one.save!
    @survivor_two.save!

    @response = { status: :success, data: { survivors: [@survivor_one.with_inventory, @survivor_two.with_inventory] } }
  end

  private

  def check_survivors
    if @survivor_one.is_infected? or @survivor_two.is_infected?
      raise 'One of the survivors is infected!'
    end
  end

  def check_resources
    unless @survivor_one.has_these_resources?(@resources_one) and @survivor_two.has_these_resources?(@resources_two)
      raise 'One of the survivors has not enough resources!'
    end
  end

  def check_resources_points
    if points_for(@resources_one) != points_for(@resources_two)
      raise 'Both sides of the trade must offer the same amount of points!'
    end
  end

  def points_for(resource)
    resource.inject(0) { |total, (resource, quantity)| total + RESOURCES_POINTS[resource] * quantity }
  end

end
