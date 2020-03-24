# frozen_string_literal: true
require 'rails_helper'

describe RequestCreator, type: :service do
  let(:request_creator) { described_class.new(data) }

  describe '.call' do
    context 'with valid params' do
      before do
        expect(DataMappers::Ticket)
          .to receive(:call)
          .with(data)
          .and_call_original

        expect(DataMappers::Excavator)
          .to receive(:call)
          .with(data[:Excavator])
          .and_call_original
      end

      it 'creates Ticket and Excavator' do
        expect do
          expect do
            request_creator.call

            expect(request_creator.success?).to eq(true)
            expect(request_creator.errors).to be_empty
          end.to change { Excavator.count }.by(1)
        end.to change { Ticket.count }.by(1)
      end
    end

    describe 'with invalid params' do
      before do
        expect(mapper_class).to receive(:call).and_raise(StandardError)
        request_creator.call
      end

      context 'for ticket' do
        let(:mapper_class) { DataMappers::Ticket }

        it 'logs error' do
          expect(request_creator.success?).to eq(false)
          expect(request_creator.errors.messages)
            .to eq({ ticket_attributes: ['are invalid'] })
        end
      end

      context 'for excavator' do
        let(:mapper_class) { DataMappers::Excavator }

        it 'logs error' do
          expect(request_creator.success?).to eq(false)
          expect(request_creator.errors.messages)
            .to eq({ excavator_attributes: ['are invalid'] })
        end
      end
    end

    describe 'with invalid attributes' do
      before do
        expect(mapper_class).to receive(:call).and_return({})
        request_creator.call
      end

      context 'for ticket' do
        let(:mapper_class) { DataMappers::Ticket }

        it 'logs error' do
          expect(request_creator.success?).to eq(false)
          expect(request_creator.errors.messages).not_to be_empty
        end
      end

      context 'for excavator' do
        let(:mapper_class) { DataMappers::Excavator }

        it 'logs error' do
          expect(request_creator.success?).to eq(false)
          expect(request_creator.errors.messages).not_to be_empty
        end
      end
    end
  end

  private

  def data
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
end
