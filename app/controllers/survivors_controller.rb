class SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:update]

  # POST /survivors
  def create
    @survivor = Survivor.new(survivor_params)

    if @survivor.save
      render json: @survivor.with_inventory,
             status: :created, location: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/ survivors/1
  def update
    if @survivor.update(survivor_params)
      render json: @survivor.with_inventory
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  def infected_locations
    @survivors = Survivor.infected.within(5, origin: [params[:lat], params[:lng]]).select(:id, :name, :latitude, :longitude, :times_reported)
    render json: @survivors, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_survivor
    @survivor = Survivor.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def survivor_params
    if action_name == 'update'
      return params.require(:survivor).permit(:latitude, :longitude)
    end
    params.require(:survivor).permit(:name, :age, :gender, :latitude, :longitude, inventory_attributes: [:water, :food, :medication, :ammunition])
  end
end
