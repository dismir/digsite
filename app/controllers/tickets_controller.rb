# frozen_string_literal: true

class TicketsController < ApplicationController
  helper_method :tickets, :ticket

  def index
    render :index
  end

  def show
    render :show
  end

  private

  def tickets
    @tickets ||= Ticket.all
  end

  def ticket
    @ticket ||= tickets.find(params[:id])
  end
end
