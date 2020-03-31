# frozen_string_literal: true

require 'teamtailor/record'

module Teamtailor
  class JobApplication < Record
    def self.deserialize(value)
      new(value)
    end

    def serialize
      data
    end

    def id
      data.dig('id').to_i
    end
  end
end
