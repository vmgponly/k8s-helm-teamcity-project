class Api::HealthCheckController < ApiController
  def index
    head :ok
  end
end
