# frozen_string_literal: true

class Excavator < ApplicationRecord
  belongs_to :ticket

  validates :ticket_id, :company_name, :address, presence: true
end
