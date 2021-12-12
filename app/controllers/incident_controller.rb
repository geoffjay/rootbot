# Controller to handle incident routes
class IncidentController < ApplicationController
  def index
    @incidents = Incident.filter(filter_params(params))
  end

  def new; end

  private

  def filter_params(params)
    params.slice(:status, :severity)
  end
end
