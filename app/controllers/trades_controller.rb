class TradesController < ApplicationController
  before_action :set_survivors_and_resources

  def create
    trade = TradesService.new(@survivor_one, @survivor_two, @resources_one, @resources_two)

    if trade.perform
      render json: trade.response, status: :ok
    else
      render json: trade.response, status: :bad_request
    end
  end

  private

  def set_survivors_and_resources
    @survivor_one = Survivor.find(params[:survivor_one]).includes(:inventory)
    @survivor_two = Survivor.find(params[:survivor_two]).includes(:inventory)
    @resources_one = params.require(:resources_one).permit(:water, :food, :medication, :ammunition)
    @resources_two = params.require(:resources_two).permit(:water, :food, :medication, :ammunition)
  end
end
