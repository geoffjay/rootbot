require 'faraday'

# Sidekiq worker to handle Slack command processing
class SlackWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params)
    return if params['text'].blank?

    command = params['text'].split.first
    @url = params['response_url']

    begin
      send("handle_#{command}", params)
    rescue NoMethodError
      # should never reach here
    end
  end

  private

  def incident_severities
    severities = Incident.severities.values
    [
      { label: 'Low', value: severities[0] },
      { label: 'Medium', value: severities[1] },
      { label: 'High', value: severities[2] },
    ]
  end

  def handle_declare(params)
    _command, title = params['text'].split(/ /, 2)
    message = {
      trigger_id: params['trigger_id'],
      dialog: {
        title: 'Declare a New Incident',
        callback_id: 'rootbot-123abc',
        elements: [
          { type: 'text', label: 'Title', name: 'title', value: title, optional: false },
          { type: 'textarea', label: 'Description', name: 'description', optional: true },
          {
            type: 'select',
            label: 'Severity',
            name: 'severity',
            optional: true,
            options: incident_severities,
          },
        ],
        state: 'incident',
        submit_label: 'Create',
        notify_on_cancel: true,
      },
    }

    Faraday.post(
      @url,
      { text: 'Declaring a new incident' }.to_json,
      'Content-Type' => 'application/json',
    )

    api_token = ENV['SLACK_ROOTBOT_API_TOKEN']
    Faraday.post(
      'https://slack.com/api/dialog.open',
      message.to_json,
      { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{api_token}" },
    )
  end

  def handle_resolve(params)
    channel_name = params['channel_name']

    # the controller checks for this to exist so it should be safe to pull it here
    incident = Incident.find_by(channel_name: channel_name)
    incident.update(status: 'resolved')

    time_to_resolve = time_diff(incident.created_at, Time.now.utc)
    message = {
      text: "Marking the incident channel `#{channel_name}` as resolved after #{time_to_resolve}",
    }

    Faraday.post(@url, message.to_json, 'Content-Type' => 'application/json')
  end

  def time_diff(start_time, end_time)
    seconds = (start_time - end_time).to_i.abs

    days = (seconds / 86_400).round
    seconds -= days * 86_400

    hours = (seconds / 3600).round
    seconds -= hours * 3600

    minutes = (seconds / 60).round

    "#{days} days, #{hours} hours and #{minutes} minutes"
  end
end
