# frozen_string_literal: true
require 'rails_helper'

describe Ticket, type: :model do
  let(:ticket) { build :ticket }

  describe 'associations' do
    it { expect(ticket).to have_one :excavator }
  end

  describe 'validations' do
    it { should validate_presence_of(:request_number) }
    it { should validate_presence_of(:sequence_number) }
    it { should validate_presence_of(:request_type) }
    it { should validate_presence_of(:response_due_date_time_at) }
    it { should validate_presence_of(:primary_service_area_code) }
    it { should validate_presence_of(:site_disposition) }
  end
end
