require 'rails_helper'

# Test suite for the Incident model
RSpec.describe Incident, type: :model do
  it 'is valid with valid attributes' do
    expect(Incident.new).to be_valid
  end

  # it { should validate_presence_of(:title) }
  it 'is valid for valid reasons'
end
