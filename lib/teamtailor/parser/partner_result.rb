# frozen_string_literal: true

require "teamtailor/record"

module Teamtailor
  class PartnerResult < Record
    def id
      data.dig("id")
    end
  end
end
