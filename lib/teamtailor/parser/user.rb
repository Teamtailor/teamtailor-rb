module Teamtailor
  class User
    def initialize(payload)
      @payload = payload
    end

    def id
      payload.dig('id').to_i
    end

    def method_missing(m)
      payload.dig('attributes', m.to_s.gsub('_', '-'))
    end

    private

    attr_reader :payload
  end
end
