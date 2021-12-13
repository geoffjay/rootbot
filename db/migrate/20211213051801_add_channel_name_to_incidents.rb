# rubocop:disable Style/Documentation
class AddChannelNameToIncidents < ActiveRecord::Migration[6.1]
  def change
    add_column :incidents, :channel_name, :string
  end
end
