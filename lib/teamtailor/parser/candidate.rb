module Teamtailor
  class Candidate
    def initialize(payload)
      @payload = payload
    end

    def self.deserialize(value)
      new(value)
    end

    def serialize
      payload
    end

    def id
      payload.dig('id').to_i
    end

    def connected?
      payload.dig('attributes', 'connected')
    end

    def method_missing(m)
      payload.dig('attributes', m.to_s.gsub('_', '-'))
    end

    private

    attr_reader :payload
  end
end
