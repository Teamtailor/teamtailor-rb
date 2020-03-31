module Teamtailor
  class Candidate
    def initialize(data)
      @data = data
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

    def connected?
      data.dig('attributes', 'connected')
    end

    def method_missing(m)
      data.dig('attributes', m.to_s.gsub('_', '-'))
    end

    private

    attr_reader :data
  end
end
