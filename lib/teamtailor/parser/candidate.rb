module Teamtailor
  class Candidate
    def initialize(payload)
      @payload = payload
    end

    def id
      payload.dig('id').to_i
    end

    def connected?
      payload.dig('attributes', 'connected')
    end

    def first_name
      payload.dig('attributes', 'first-name')
    end

    def last_name
      payload.dig('attributes', 'last-name')
    end

    def email
      payload.dig('attributes', 'email')
    end

    def tags
      payload.dig('attributes', 'tags')
    end

    private

    attr_reader :payload
  end
end
