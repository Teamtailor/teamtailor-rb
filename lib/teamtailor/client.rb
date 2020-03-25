# frozen_string_literal: true

module Teamtailor
  class Client
    def initialize(base_url:, api_token:, api_version:)
      @base_url = base_url
      @api_token = api_token
      @api_version = api_version
    end

    def get(path, params = {})
      request = Typhoeus::Request.new(
        "#{base_url}#{path}",
        method: :get,
        params: params,
        headers: request_headers
      )
      response = request.run

      raise response_error(response) if response_error(response)

      JSON.parse(response.body)
    end

    private

    attr_reader :base_url, :api_token, :api_version

    def response_error(response)
      Teamtailor::Error.from_response body: response.body, status: response.code
    end

    def request_headers
      {
        "Token": "Token token=#{api_token}",
        'X-Api-Version' => api_version,
        'User-Agent' => "teamtailor-rb v#{Teamtailor::VERSION}",
        'Content-Type' => 'application/vnd.api+json; charset=utf-8'
      }
    end
  end
end
