class InfectionsController < ApplicationController
  before_action :check_survivors, :set_survivors
  def create
    if @survivor_one.reports_infection_of @survivor_two
      render json: { status: :success, data: { survivor: @survivor_two } }, status: :ok
    else
      render json: { status: :error, errors: @survivor_one.errors.full_messages }, status: :bad_request
    end
  end

  private

  def set_survivors
    @survivor_one = Survivor.find(params[:survivor_one])
    @survivor_two = Survivor.find(params[:survivor_two])
  end

  def check_survivors
    if params[:survivor_one] == params[:survivor_two]
      render json: { status: :error, message: 'Survivors must be different!' }, status: :bad_request
    end
  end
end
