# frozen_string_literal: true
require 'rails_helper'

describe TicketsController, type: :controller do
  describe 'GET index' do
    subject { get :index }

    it 'returns status 200 and renders the index template' do
      expect(subject.status).to eq(200)
      expect(subject).to render_template('index')
    end
  end

  describe 'GET show' do
    let(:ticket) { create :ticket }
    let!(:excavator) { create :excavator, ticket: ticket}

    subject { get :show, params: { id: ticket.id } }

    it 'returns status 302 and update record' do
      expect(subject.status).to eq(200)
      expect(subject).to render_template('show')
    end
  end
end
