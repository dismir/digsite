# frozen_string_literal: true

module DataMappers
  class Ticket < DataMappers::Base
    POLYGON_REGEX = /POLYGON\(\((.*)\)\)/.freeze

    private

    def attributes
      {
        request_number: params['RequestNumber'],
        sequence_number: params['SequenceNumber'],
        request_type: params['RequestType'],
        response_due_date_time_at: response_due_date_time_at,
        primary_service_area_code: params['ServiceArea']['PrimaryServiceAreaCode']['SACode'],
        service_area_codes: service_area_codes,
        site_disposition: site_disposition
      }
    end

    def response_due_date_time_at
      Time.zone.parse(params['DateTimes']['ResponseDueDateTime'])
    end

    def service_area_codes
      params['ServiceArea']['AdditionalServiceAreaCodes']['SACode'].join(', ')
    end

    def site_disposition
      POLYGON_REGEX
        .match(params['ExcavationInfo']['DigsiteInfo']['WellKnownText'])[1]
        .split(',').map do |latlon|
          lat, lon = latlon.split(' ')
          { lat: lat.to_f, lon: lon.to_f }
        end
    end
  end
end
