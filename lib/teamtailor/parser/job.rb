# frozen_string_literal: true

require 'teamtailor/record'

module Teamtailor
  class Job < Record
    def self.deserialize(value)
      new(value)
    end

    def serialize
      data
    end

    def careersite_job_url
      data.dig('links', 'careersite-job-url')
    end
  end
end
