# frozen_string_literal: true

require 'teamtailor/record'

module Teamtailor
  class Candidate < Record
    def connected?
      data.dig('attributes', 'connected')
    end
  end
end
