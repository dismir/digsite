# frozen_string_literal: true
require 'rails_helper'

describe DataMappers::Excavator, type: :service do
  subject { described_class.call(params) }

  describe '.call' do
    context 'if params are valid' do
      let(:params) do
        {
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
      end
      let(:expected_hash) do
        {
          address: {
            street: '555 Some RD',
            city: 'SOME PARK',
            state: 'ZZ',
            zip: '55555',
            contact: {
              name: 'Johnny Doe',
              phone: '1115552345',
              email: 'example@example.com'
            },
            field_contact: {
              name: 'Field Contact',
              phone: '1235557924',
              email: 'example@example.com'
            }
          },
          company_name: 'John Doe CONSTRUCTION',
          crew_on_site: false
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
