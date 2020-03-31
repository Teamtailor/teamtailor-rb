# frozen_string_literal: true

require 'teamtailor/record'

module Teamtailor
  class JobApplication < Record
    def self.deserialize(value)
      payload = JSON.parse value
      new(payload['data'], payload['included'])
    end

    def serialize
      {
        data: data,
        included: included
      }.to_json
    end

    def id
      data.dig('id').to_i
    end
  end
end
