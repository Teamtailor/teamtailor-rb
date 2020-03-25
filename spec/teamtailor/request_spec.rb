# frozen_string_literal: true

require 'securerandom'

require 'teamtailor/request'

RSpec.describe Teamtailor::Request do
  describe '#call' do
    it 'returns a Teamtailor::PageResult' do
      api_token = SecureRandom.uuid
      request = Teamtailor::Request.new(
        base_url: 'http://api.teamtailor.localhost',
        api_token: api_token,
        api_version: 20_161_108,
        path: '/v1/nonsense'
      )

      stub_request(:get, 'http://api.teamtailor.localhost/v1/nonsense')
        .with(
          headers: {
            "Authorization": "Token token=#{api_token}",
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

      page_result = request.call
      expect(page_result.class).to eq Teamtailor::PageResult
    end

    context 'passing query params' do
      it 'passes them along to the request' do
        api_token = SecureRandom.uuid
        request = Teamtailor::Request.new(
          base_url: 'http://api.teamtailor.localhost',
          api_token: api_token,
          api_version: 20_161_108,
          path: '/v1/nonsense',
          params: {
            'page[size]': 3
          }
        )

        stub_request(:get, 'http://api.teamtailor.localhost/v1/nonsense')
          .with(
            query: {
              'page[size]': 3
            }
          )
          .to_return(status: 200, body: {}.to_json)

        request.call
      end
    end

    context 'getting a 401 response' do
      it 'raises an Teamtailor::UnauthorizedError' do
        api_token = SecureRandom.uuid
        request = Teamtailor::Request.new(
          base_url: 'http://api.teamtailor.localhost',
          api_token: api_token,
          api_version: 20_161_108,
          path: '/v1/candidates'
        )

        stub_request(:get, 'http://api.teamtailor.localhost/v1/candidates')
          .with(
            headers: {
              "Authorization": "Token token=#{api_token}",
              'X-Api-Version' => 20_161_108,
              'User-Agent' => "teamtailor-rb v#{Teamtailor::VERSION}",
              'Content-Type' => 'application/vnd.api+json; charset=utf-8'
            }
          )
          .to_return(status: 401, body: '')

        expect do
          request.call
        end.to(raise_error { Teamtailor::UnauthorizedRequestError })
      end
    end

    context 'getting a 406 response' do
      it 'raises an Teamtailor::InvalidApiVersionError' do
        api_token = SecureRandom.uuid
        request = Teamtailor::Request.new(
          base_url: 'http://api.teamtailor.localhost',
          api_token: api_token,
          api_version: 20_161_108,
          path: '/v1/candidates'
        )

        stub_request(:get, 'http://api.teamtailor.localhost/v1/candidates')
          .to_return(status: 406, body:
          '{"errors":[{"status":406,"title":"Invalid/Missing API Version","detail":"Please provide a correct API version in the X-Api-Version header. Current version is: 20161108"}]}')

        expect do
          request.call
        end.to(raise_error { Teamtailor::InvalidApiVersionError })
      end
    end
  end
end
