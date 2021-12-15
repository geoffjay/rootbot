# Controller to handle Slack slash commands
class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create interact]

  BOT_TOKEN = ENV['SLACK_ROOTBOT_API_TOKEN']

  def create
    return json_response({}, :forbidden) unless valid_token?

    # rubocop:disable Style/IfUnlessModifier
    unless supported_command?
      return json_response({ text: "`#{slack_command}` is not a supported command" }, :ok)
    end

    channel_name = params['channel_name']
    unless Incident.exists?(channel_name: channel_name)
      message = { text: "unable to resolve, no incident for #{channel_name} was found" }
      return json_response(message, :ok) if slack_command == 'resolve'
    end

    SlackWorker.perform_async(slack_params.to_h)
    json_response({ response_type: 'in_channel' }, :created)
  end

  def interact
    # this only happens on declare so don't need to check for the command
    payload = JSON.parse(params[:payload])
    channel_name, channel_id = create_channel(payload.dig('team', 'id'))
    add_user_to_channel(channel_id, payload.dig('user', 'id'))

    creator = payload.dig('user', 'name')
    title = payload.dig('submission', 'title')
    description = payload.dig('submission', 'description')
    severity = payload.dig('submission', 'severity')

    Incident.create(
      title: title,
      channel_name: channel_name,
      creator: creator,
      description: description,
      severity: severity,
      status: 'unresolved',
    )

    head :no_content
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

  def create_channel(team_id)
    channel_name = "inc-#{RandomWord.adjs.first}-#{RandomWord.nouns.first}"
    message = { name: channel_name, is_private: false, team_id: team_id }

    response =
      Faraday.post(
        'https://slack.com/api/conversations.create',
        message.to_json,
        { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{BOT_TOKEN}" },
      )
    body = JSON.parse(response.body)

    [channel_name, body.dig('channel', 'id')]
  end

  def add_user_to_channel(channel_id, user_id)
    message = { channel: channel_id, users: user_id }

    Faraday.post(
      'https://slack.com/api/conversations.invite',
      message.to_json,
      { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{BOT_TOKEN}" },
    )
  end
end
