# frozen_string_literal: true

module Teamtailor
  class User
    def initialize(data, _included = {})
      @data = data
      @included = included
    end

    def self.deserialize(value)
      new(value)
    end

    def serialize
      data
    end

    def id
      data.dig('id').to_i
    end

    def method_missing(m)
      data.dig('attributes', m.to_s.gsub('_', '-'))
    end

    private

    attr_reader :data
  end
end
