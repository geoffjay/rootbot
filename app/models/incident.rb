class Incident < ApplicationRecord
  include Filterable

  enum severity: { sev0: 'sev0', sev1: 'sev1', sev2: 'sev2' }
  enum status: { unresolved: 'unresolved', resolved: 'resolved' }

  scope :filter_by_severity, ->(severity) { where severity: severity }
  scope :filter_by_status, ->(status) { where status: status }
end
