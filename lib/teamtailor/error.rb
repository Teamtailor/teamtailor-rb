# frozen_string_literal: true

module Teamtailor
  class Error < StandardError
    def self.from_response(body:, status:)
      case status
      when 401
        Teamtailor::UnauthorizedRequestError.new
      when 406
        json_response = JSON.parse(body)
        Teamtailor::InvalidApiVersionError.new(
          json_response.dig("errors", "detail")
        )
      end
    end
  end

  class ClientError < Error; end

  class UnauthorizedRequestError < ClientError; end

  class InvalidApiVersionError < ClientError; end

  class JSONError < ClientError; end

  class UnknownResponseTypeError < ClientError; end

  class UnloadedRelationError < ClientError; end
end
