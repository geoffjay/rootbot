# Controller to handle Slack slash commands
class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create interact]

  def create
    return json_response({}, :forbidden) unless valid_token?
    unless supported_command?
      return json_response({ text: "`#{slack_command}` is not a supported command" }, :ok)
    end

    channel_name = params['channel_name']
    unless Incident.exists?(channel_name: channel_name)
      message = { text: "unable to resolve, no incident for #{channel_name} was found" }
      return json_response(message, :ok)
    end

    SlackWorker.perform_async(slack_params.to_h)
    json_response({ response_type: 'in_channel' }, :created)
  end

  def interact
    # puts params
    # this only happens on declare so don't need to check
    # create a dedicated slack channel
    # create incident
  end

  private

  def slack_params
    params.permit(
      :token,
      :team_domain,
      :channel_name,
      :user_name,
      :command,
      :text,
      :response_url,
      :trigger_id,
    )
  end

  def slack_command
    params[:text].split.first if params[:text].present?
  end

  def valid_token?
    params[:token] == ENV['SLACK_ROOTBOT_TOKEN']
  end

  def supported_command?
    %w[declare resolve].include? slack_command
  end
end
