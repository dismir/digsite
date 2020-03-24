# frozen_string_literal: true
require 'rails_helper'

describe Excavator, type: :model do
  let(:excavator) { build :excavator }

  describe 'associations' do
    it { expect(excavator).to belong_to :ticket }
  end

  describe 'validations' do
    it { should validate_presence_of(:ticket_id) }
    it { should validate_presence_of(:company_name) }
    it { should validate_presence_of(:address) }
  end
end
