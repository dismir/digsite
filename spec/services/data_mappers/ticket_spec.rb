# frozen_string_literal: true
require 'rails_helper'

describe DataMappers::Ticket, type: :service do
  subject { described_class.call(params) }

  describe '.call' do
    context 'if params are valid' do
      let(:params) do
        {
          'RequestNumber': '09252012-00001',
          'SequenceNumber': '2421',
          'RequestType': 'Normal',
          'ServiceArea': {
            'PrimaryServiceAreaCode': { 'SACode': 'ZZGL103' },
            'AdditionalServiceAreaCodes': { 'SACode': ['ZZL01', 'ZZL02', 'ZZL03'] }
          },
          'DateTimes': { 'ResponseDueDateTime': '2011/07/13 23:59:59' },
          'ExcavationInfo': {
            'DigsiteInfo': {
                'WellKnownText': 'POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))'
            }
          },
          'Excavator': {
            'CompanyName': 'John Doe CONSTRUCTION',
            'Address': '555 Some RD',
            'City': 'SOME PARK',
            'State': 'ZZ',
            'Zip': '55555',
            'Contact': {
              'Name': 'Johnny Doe',
              'Phone': '1115552345',
              'Email': 'example@example.com'
            },
            'FieldContact': {
              'Name': 'Field Contact',
              'Phone': '1235557924',
              'Email': 'example@example.com'
            }
          }
        }
      end
      let(:expected_hash) do
        {
          primary_service_area_code: 'ZZGL103',
          request_number: '09252012-00001',
          request_type: 'Normal',
          response_due_date_time_at: Time.parse('2011-07-13 23:59:59.000000000 +0000'),
          sequence_number: '2421',
          service_area_codes: 'ZZL01, ZZL02, ZZL03',
          site_disposition: [
            { lat: -81.13390268058475, lon: 32.07206917625161 },
            { lat: -81.14660562247929, lon: 32.04064386441295 },
            { lat: -81.08858407706913, lon: 32.02259853170128 },
            { lat: -81.05322183341679, lon: 32.02434500961698 },
            { lat: -81.05047525138554, lon: 32.042681017283066 },
            { lat: -81.0319358226746, lon: 32.06537765335268 },
            { lat: -81.01202310294804, lon: 32.078469305179404 },
            { lat: -81.02850259513554, lon: 32.07963291684719 },
            { lat: -81.07759774894413, lon: 32.07090546831167 },
            { lat: -81.12154306144413, lon: 32.08806865844325 },
            { lat: -81.13390268058475, lon: 32.07206917625161}
          ]
        }
      end

      it 'returns mapped data' do
        is_expected.to eq(expected_hash)
      end
    end

    context 'if params are invalid' do
      let(:params) { {} }

      it 'raise an error' do
        expect { subject }.to raise_error(NoMethodError)
      end
    end
  end
end
