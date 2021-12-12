# Controller to handle Slack slash commands
class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create]

  def create
    return json_response({}, :forbidden) unless valid_token?

    SlackWorker.perform_async(slack_params.to_h)
    json_response({ response_type: 'in_channel' }, :created)
  end

  private

  def slack_params
    params.permit(:token, :team_domain, :channel_name, :user_name, :command, :text, :response_url)
  end

  def slack_command
    params[:text].split.first if params[:text].present?
  end

  def valid_token?
    params[:token] == ENV['SLACK_ROOTBOT_TOKEN']
  end
end
