# frozen_string_literal: true

class RequestCreator < ::BaseService
  attr_reader :errors

  def initialize(params)
    @params = params.to_h.with_indifferent_access
    @errors = ActiveModel::Errors.new(self)
  end

  def call
    Ticket.transaction do
      ticket.save!
      excavator.save!
    end
  rescue ActiveRecord::RecordInvalid => e
    self.errors = e.record.errors
  ensure
    return self
  end

  def success?
    errors.empty?
  end

  def ticket
    @ticket ||= Ticket.new(ticket_attributes)
  end

  def excavator
    @excavator ||= ticket.build_excavator(excavator_attributes)
  end

  private

  attr_reader :params
  attr_writer :errors

  def ticket_attributes
    DataMappers::Ticket.call(params)
  rescue StandardError
    errors.add(:ticket_attributes, 'are invalid')
  end

  def excavator_attributes
    DataMappers::Excavator.call(params['Excavator'])
  rescue StandardError
    errors.add(:excavator_attributes, 'are invalid')
  end
end
