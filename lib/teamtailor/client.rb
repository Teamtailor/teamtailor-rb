# frozen_string_literal: true

require "teamtailor/request"

module Teamtailor
  class Client
    def initialize(base_url:, api_token:, api_version:)
      @base_url = base_url
      @api_token = api_token
      @api_version = api_version
    end

    def company(include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/company",
        params: {
          "include" => include.join(","),
        }
      ).call
    end

    def candidates(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/candidates",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def create_candidate(attributes:, relationships:)
      Teamtailor::Request.new(
          base_url: base_url,
          api_token: api_token,
          api_version: api_version,
          path: "/v1/candidates",
          method: :post,
          body: {
              data: {
                  type: "candidates",
                  attributes: attributes.transform_keys { |k| k.to_s.gsub("_", "-") },
                  relationships: relationships,
              },
          }
      ).call
    end

    def jobs(page: 1, include: [], filters: {})
      filter_params = filters.transform_keys { |key| "filter[#{key}]" }

      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/jobs",
        params: {
          'page[number]' => page,
          'page[size]' => 30,
          'include' => include.join(','),
        }#.merge(*filter_params)
      ).call
    end

    def job_applications(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/job-applications",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def create_upload(attributes:, relationships:)
      Teamtailor::Request.new(
          base_url: base_url,
          api_token: api_token,
          api_version: api_version,
          path: "/v1/uploads",
          method: :post,
          body: {
              data: {
                  type: "uploads",
                  attributes: attributes.transform_keys{ |k| k.to_s.gsub("_", "-") },
                  relationships: relationships,
              },
          }
      ).call
    end

    def create_job_application(candidate_id:, job_id:, **args)
      Teamtailor::Request.new(
          base_url: base_url,
          api_token: api_token,
          api_version: api_version,
          path: "/v1/job-applications",
          method: :post,
          body: {
              data: {
                  type: "job-applications",
                  attributes: attributes.transform_keys { |k| k.to_s.gsub("_", "-") },
                  relationships: relationships,
              },
          }
      ).call
    end

    def users(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/users",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def stages(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/stages",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def reject_reasons(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/reject-reasons",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def departments(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/departments",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def locations(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/locations",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def custom_fields(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/custom-fields",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def custom_field_values(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/custom-field-values",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def referrals(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/referrals",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def partner_results(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/partner-results",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
        }
      ).call
    end

    def requisitions(page: 1, include: [])
      Teamtailor::Request.new(
        base_url: base_url,
        api_token: api_token,
        api_version: api_version,
        path: "/v1/requisitions",
        params: {
          "page[number]" => page,
          "page[size]" => 30,
          "include" => include.join(","),
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
