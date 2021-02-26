require "typhoeus"
require "json"

require "teamtailor/page_result"

module Teamtailor
  class Request
    def initialize(base_url:, api_token:, api_version:, path:, params: {}, body: {}, method: :get)
      @base_url = base_url
      @api_token = api_token
      @api_version = api_version
      @path = path
      @params = params
      @method = method
      @body = body
    end

    def call
      request = Typhoeus::Request.new(
        "#{base_url}#{path}",
        method: method,
        params: params,
        headers: request_headers,
        body: body.to_json
      )
      response = request.run

      if response.code == 200
        Teamtailor::PageResult.new response.body
      elsif response.code == 201
        Teamtailor::Parser.parse(JSON.parse(response.body)).first
      else
        raise Teamtailor::Error.from_response(
          body: response.body,
          status: response.code
        )
      end
    end

    private

    attr_reader :base_url, :path, :api_token, :api_version, :params, :method, :body

    def request_headers
      {
        "Authorization": "Token token=#{api_token}",
        "X-Api-Version" => api_version,
        "User-Agent" => "teamtailor-rb v#{Teamtailor::VERSION}",
        "Content-Type" => "application/vnd.api+json; charset=utf-8",
      }
    end
  end
end
