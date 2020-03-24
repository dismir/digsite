# frozen_string_literal: true

module DataMappers
  class Base < ::BaseService
    def initialize(params)
      @params = params.with_indifferent_access
    end

    def call
      attributes
    end

    private

    attr_reader :params

    def attributes
      raise NotIMplementedError
    end
  end
end
