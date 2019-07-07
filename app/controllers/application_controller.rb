class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render json: { status: :error, message: "Record not found!" }, status: :bad_request
  end

end
