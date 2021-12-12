# rubocop:disable Style/Documentation
class CreateIncidents < ActiveRecord::Migration[6.1]
  def change
    create_table :incidents do |t|
      t.string :title, :creator
      t.text :description
      t.datetime :resolved_at
      t.timestamps
    end
  end
end
