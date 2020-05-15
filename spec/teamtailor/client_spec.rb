# frozen_string_literal: true

require 'teamtailor/client'

RSpec.describe Teamtailor::Client do
  describe "#jobs" do
    context "passing filters" do
      it "passes them along in the request" do
        client = Teamtailor::Client.new(
          base_url: "http://api.teamtailor.localhost",
          api_token: "foobar",
          api_version: "123",
        )

        stub_request(:get, 'http://api.teamtailor.localhost/v1/jobs')
          .with(
            query: {
              'page[number]': 1,
              'page[size]': 30,
              'include': "",
              'filter[status]': 'all',
            }
          )
          .to_return(status: 200, body: {}.to_json)

        client.jobs filters: {
          status: 'all',
        }
      end
    end
  end
end
