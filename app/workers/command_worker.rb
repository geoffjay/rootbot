# Sidekiq worker to handle Slack command processing
class CommandWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
  end
end
