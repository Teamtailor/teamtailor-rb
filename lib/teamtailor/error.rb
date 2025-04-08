# frozen_string_literal: true

module Teamtailor
  class Error < StandardError
    def self.from_response(body:, status:)
      json_response = parse_body(body)

      error_message = json_response.dig("errors", 0, "detail") || json_response.dig("errors", "detail") || "Unknown error"

      case status
      when 401
        Teamtailor::UnauthorizedRequestError.new
      when 406
        Teamtailor::InvalidApiVersionError.new(error_message)
      when 422
        Teamtailor::UnprocessableEntityError.new(error_message)
      when 400..499
        ClientError.new(error_message)
      when 500..599
        ServerError.new(error_message)
      else
        UnknownResponseError.new("Unexpected error (status: #{status})")
      end
    end

    def self.parse_body(body)
      begin
        JSON.parse(body)
      rescue JSON::ParserError => e
        {}
      end
    end
  end

  class ClientError < Error; end

  class ServerError < Error; end

  class UnauthorizedRequestError < ClientError; end

  class InvalidApiVersionError < ClientError; end

  class JSONError < ClientError; end

  class UnknownResponseTypeError < ClientError; end

  class UnloadedRelationError < ClientError; end

  class UnprocessableEntityError < ClientError; end

  class UnknownResponseError < Error; end
end
