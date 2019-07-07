class DetailsController < ApplicationController
  before_action :check_survivors

  RESOURCES_TYPES = [:water, :food, :medication, :ammunition]
  RESOURCES_POINTS = { water: 4, food: 3, medication: 2, ammunition: 1 }.with_indifferent_access

  def infected_survivors
    render json: { status: :success, data: percent(Survivor.infected.size, Survivor.all.size) }, status: :ok
  end

  def not_infected_survivors
    render json: { status: :success, data: percent(Survivor.not_infected.size, Survivor.all.size) }, status: :ok
  end

  def average_resources_by_survivor
    survivors = Survivor.includes(:inventory)
    survivors_size = survivors.size

    averages = RESOURCES_TYPES.reduce({}) do |avg, resource|
      avg.update(resource => survivors.sum(resource).fdiv(survivors_size).round(2))
    end

    render json: { status: :success, data: averages }, status: :ok
  end

  def points_lost_due_to_infected
    survivors = Survivor.infected.includes(:inventory)
    points_lost = survivors.sum(:cached_points)

    render json: { status: :success, data: { points_lost: points_lost } }, status: :ok
  end

  private

  def check_survivors
    render json: { status: :error, message: 'There are no survivors!' }, status: :bad_request unless Survivor.any?
  end

  def percent(part, total)
    (part.fdiv(total) * 100).round(2).to_s + "%"
  end

end