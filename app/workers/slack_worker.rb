# Sidekiq worker to handle Slack command processing
class SlackWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(params)
    message = { text: 'something something' }

    HTTParty.post(
      params[:response_url],
      { body: message.to_json, headers: { 'Content-Type' => 'application/json' } },
    )
  end
end
