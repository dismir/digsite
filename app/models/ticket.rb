# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_one :excavator, dependent: :destroy

  validates :request_number, :sequence_number, :request_type,
            :response_due_date_time_at, :primary_service_area_code,
            :site_disposition, presence: true
end
