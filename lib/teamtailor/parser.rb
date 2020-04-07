# frozen_string_literal: true

require 'teamtailor/parser/candidate'
require 'teamtailor/parser/job'
require 'teamtailor/parser/user'
require 'teamtailor/parser/job_application'
require 'teamtailor/parser/company'
require 'teamtailor/parser/stage'
require 'teamtailor/parser/reject_reason'
require 'teamtailor/parser/department'
require 'teamtailor/parser/location'

module Teamtailor
  class Parser
    def self.parse(payload)
      new(payload).parse
    end

    def parse
      data.map do |record|
        case record&.dig('type')
        when 'candidates' then Teamtailor::Candidate.new(record, included)
        when 'jobs' then Teamtailor::Job.new(record, included)
        when 'users' then Teamtailor::User.new(record, included)
        when 'job-applications' then Teamtailor::JobApplication.new(record, included)
        when 'companies' then Teamtailor::Company.new(record, included)
        when 'stages' then Teamtailor::Stage.new(record, included)
        when 'reject-reasons' then Teamtailor::RejectReason.new(record, included)
        when 'departments' then Teamtailor::Department.new(record, included)
        when 'locations' then Teamtailor::Location.new(record, included)

        else
          raise Teamtailor::UnknownResponseTypeError, record&.dig('type')
        end
      end
    end

    private

    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def data
      [payload&.dig('data')].flatten
    end

    def included
      payload&.dig('included')
    end
  end
end
