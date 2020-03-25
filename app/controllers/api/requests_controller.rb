# frozen_string_literal: true

module Api
  class RequestsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :validate_request_content_type

    def create
      request_creator = RequestCreator.call(permitted_params.to_h)

      if request_creator.success?
        render json: request_creator.ticket.to_json(include: :excavator), status: :created
      else
        render json: { errors: request_creator.errors }, status: :bad_request
      end
    end

    private

    def validate_request_content_type
      return if request.content_type == 'application/json'

      head :not_acceptable
    end

    def permitted_params
      params.permit(
        :RequestNumber,
        :SequenceNumber,
        :RequestType,
        ServiceArea: [
          PrimaryServiceAreaCode: [:SACode],
          AdditionalServiceAreaCodes: [SACode: []]
        ],
        DateTimes: [:ResponseDueDateTime],
        ExcavationInfo: [DigsiteInfo: [:WellKnownText]],
        Excavator: [
          :CompanyName,
          :Address,
          :City,
          :State,
          :Zip,
          Contact: %i[Name Phone Email],
          FieldContact: %i[Name Phone Email]
        ]
      )
    end
  end
end
