# frozen_string_literal: true

require 'securerandom'

RSpec.describe Teamtailor::Client do
  describe '#get' do
    it 'works' do
      api_token = SecureRandom.uuid
      client = Teamtailor::Client.new(
        base_url: 'http://api.teamtailor.localhost',
        api_token: api_token,
        api_version: 20_161_108
      )

      stub_request(:get, 'http://api.teamtailor.localhost/v1/nonsense')
        .with(
          headers: {
            "Token": "Token token=#{api_token}",
            'X-Api-Version' => 20_161_108,
            'User-Agent' => "teamtailor-rb v#{Teamtailor::VERSION}",
            'Content-Type' => 'application/vnd.api+json; charset=utf-8'
          }
        )
        .to_return(status: 200, body: { nonsense: true }.to_json, headers: {
                     'X-Api-Version' => 20_161_108,
                     'X-Rate-Limit-Limit' => 100,
                     'X-Rate-Limit-Remaining' => 100,
                     'X-Rate-Limit-Reset' => 1,
                     'Content-Type' => 'application/vnd.api+json; charset=utf-8'
                   })

      response = client.get '/v1/nonsense'

      expect(response).to eq({ "nonsense" => true })
    end

    context 'getting a 401 response' do
      it 'raises an Teamtailor::UnauthorizedError' do
        api_token = SecureRandom.uuid
        client = Teamtailor::Client.new(
          base_url: 'http://api.teamtailor.localhost',
          api_token: api_token,
          api_version: 20_161_108
        )

        stub_request(:get, 'http://api.teamtailor.localhost/v1/candidates')
          .with(
            headers: {
              "Token": "Token token=#{api_token}",
              'X-Api-Version' => 20_161_108,
              'User-Agent' => "teamtailor-rb v#{Teamtailor::VERSION}",
              'Content-Type' => 'application/vnd.api+json; charset=utf-8'
            }
          )
          .to_return(status: 401, body: '')

        expect do
          client.get '/v1/candidates'
        end.to(raise_error { Teamtailor::UnauthorizedRequestError })
      end
    end

    context 'getting a 406 response' do
      it 'raises an Teamtailor::InvalidApiVersionError' do
        api_token = SecureRandom.uuid
        client = Teamtailor::Client.new(
          base_url: 'http://api.teamtailor.localhost',
          api_token: api_token,
          api_version: 20_161_108
        )

        stub_request(:get, 'http://api.teamtailor.localhost/v1/candidates')
          .to_return(status: 406, body: {
            "errors": [
              {
                "status": 406,
                "title": 'Invalid/Missing API Version',
                "detail": <<~DETAIL
                  Please provide a correct API version in the X-Api-Version header. Current version is: 20161108
                DETAIL
              }
            ]
          }.to_json)

        expect do
          client.get '/v1/candidates'
        end.to(raise_error { Teamtailor::InvalidApiVersionError })
      end
    end
  end

  private

  def json_response
    JSON.parse response.body
  end
end
