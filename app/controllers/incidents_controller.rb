# Controller to handle incident routes
class IncidentsController < ApplicationController
  before_action :set_incident, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token, only: %i[create update show]

  def index
    @incidents = Incident.filter(filter_params)
  end

  def create
    @incident = Incident.create!(incident_params)
    json_response(@incident, :created)
  end

  def edit; end

  def update
    incident.update!(incident_params)
    head :no_content
  end

  def show
    json_response(@incident)
  end

  def destroy
    @incident.destroy
    head :no_content
  end

  private

  def filter_params
    params.slice(:status, :severity)
  end

  def incident_params
    params.permit(:title, :description, :severity, :status)
  end

  def set_incident
    @incident = Incident.find(params[:id])
  end
end
