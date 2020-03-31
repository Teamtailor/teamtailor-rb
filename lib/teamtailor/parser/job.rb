module Teamtailor
  class Job
    def initialize(data, included = {})
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

    def careersite_job_url
      data.dig('links', 'careersite-job-url')
    end

    def user
      Teamtailor::Relationship.new('user', data.dig('relationships'), included)
    end

    def method_missing(m)
      data.dig('attributes', m.to_s.gsub('_', '-'))
    end

    private

    attr_reader :data, :included
  end
end
