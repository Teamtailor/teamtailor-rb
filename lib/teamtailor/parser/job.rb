module Teamtailor
  class Job
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

    def careersite_job_url
      payload.dig('links', 'careersite-job-url')
    end

    def method_missing(m)
      payload.dig('attributes', m.to_s.gsub('_', '-'))
    end

    private

    attr_reader :payload
  end
end
