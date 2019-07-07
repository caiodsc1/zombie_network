class TradesController < ApplicationController
  before_action :set_survivors_and_resources

  def create
    trade = TradesService.new(@survivor_one, @survivor_two, @resources_one.to_h, @resources_two.to_h)

    if trade.perform
      render json: trade.response, status: :ok
    else
      render json: trade.response, status: :bad_request
    end
  end

  private

  def set_survivors_and_resources
    @survivor_one = Survivor.includes(:inventory).find(params[:survivor_one])
    @survivor_two = Survivor.includes(:inventory).find(params[:survivor_two])
    @resources_one = params.require(:resources_one).permit(:water, :food, :medication, :ammunition)
    @resources_two = params.require(:resources_two).permit(:water, :food, :medication, :ammunition)
  end
end
