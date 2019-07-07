require "rails_helper"

RSpec.describe SurvivorsController, type: :routing do
  describe "Tests if route matches correct action" do

    it "Routes to action infected_survivors" do
      expect(:get => "/infected_survivors").to route_to("details#infected_survivors")
    end

    it "Routes to action not_infected_survivors" do
      expect(:get => "/not_infected_survivors").to route_to("details#not_infected_survivors")
    end

    it "Routes to action average_resources_by_survivor" do
      expect(:get => "/average_resources").to route_to("details#average_resources_by_survivor")
    end

    it "Routes to action points_lost" do
      expect(:get => "/points_lost").to route_to("details#points_lost_due_to_infected")
    end
  end
end