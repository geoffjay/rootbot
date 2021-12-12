# Generic filter support
module Filterable
  extend ActiveSupport::Concern

  # Methods to add to classes extending this
  module ClassMethods
    def filter(filter_params)
      results = where(nil)
      filter_params.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
      results
    end
  end
end
