require 'typhoeus'
require 'json'

require 'teamtailor/page_result'

module Teamtailor
  class Request
    def initialize(base_url:, api_token:, api_version:, path:, params: {})
      @base_url = base_url
      @api_token = api_token
      @api_version = api_version
      @path = path
      @params = params
    end

    def call
      request = Typhoeus::Request.new(
        "#{base_url}#{path}",
        method: :get,
        params: params,
        headers: request_headers
      )
      response = request.run

      if response.code == 200
        Teamtailor::PageResult.new response.body
      else
        raise Teamtailor::Error.from_response(
          body: response.body,
          status: response.code
        )
      end
    end

    private

    attr_reader :base_url, :path, :api_token, :api_version, :params

    def request_headers
      {
        "Authorization": "Token token=#{api_token}",
        'X-Api-Version' => api_version,
        'User-Agent' => "teamtailor-rb v#{Teamtailor::VERSION}",
        'Content-Type' => 'application/vnd.api+json; charset=utf-8'
      }
    end
  end
end
