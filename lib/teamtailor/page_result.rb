# frozen_string_literal: true

require 'teamtailor/parser'

module Teamtailor
  class PageResult
    def initialize(response_body)
      @json_response = JSON.parse(response_body)
    end

    def records
      Teamtailor::Parser.parse json_response
    end

    def data
      json_response.dig('data')
    end

    def page_count
      json_response.dig('meta', 'page-count')
    end

    def record_count
      json_response.dig('meta', 'record-count')
    end

    def next_page_url
      json_response.dig('links', 'next')
    end

    def first_page_url
      json_response.dig('links', 'first')
    end

    def last_page_url
      json_response.dig('links', 'last')
    end

    def has_next_page?
      !next_page_url.nil?
    end

    private

    attr_reader :json_response
  end
end
