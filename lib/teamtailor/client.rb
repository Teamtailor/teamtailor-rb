# frozen_string_literal: true

require 'teamtailor/request'

module Teamtailor
  class Client
    def initialize(base_url:, api_token:, api_version:)
      @base_url = base_url
      @api_token = api_token
      @api_version = api_version
    end

    def candidates(page: 1)
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: '/v1/candidates',
        params: {
          'page[number]' => page,
          'page[size]' => 30
        }
      ).call
    end

    def jobs(page: 1)
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: '/v1/jobs',
        params: {
          'page[number]' => page,
          'page[size]' => 30
        }
      ).call
    end

    def users(page: 1)
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: '/v1/users',
        params: {
          'page[number]' => page,
          'page[size]' => 30
        }
      ).call
    end

    private

    attr_reader :base_url, :api_token, :api_version

    def response_error(response)
      Teamtailor::Error.from_response body: response.body, status: response.code
    end
  end
end
