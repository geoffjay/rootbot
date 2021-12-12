# rubocop:disable Style/Documentation
# rubocop:disable Rails/BulkChangeTable
class AddDetailsToIncidents < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL.squish
      CREATE TYPE incident_severity as ENUM ('sev0', 'sev1', 'sev2');
      CREATE TYPE incident_status as ENUM ('unresolved', 'resolved');
    SQL

    add_column :incidents, :severity, :incident_severity
    add_column :incidents, :status, :incident_status

    add_index :incidents, :status
  end

  def down
    remove_column :incidents, :severity
    remove_column :incidents, :status

    execute <<-SQL.squish
      DROP TYPE incident_severity;
      DROP TYPE incident_status;
    SQL
  end
end
