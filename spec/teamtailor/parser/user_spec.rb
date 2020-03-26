require 'teamtailor/parser/user'

RSpec.describe Teamtailor::User do
  describe 'testing getters' do
    let(:user) do
      payload = File.read 'spec/fixtures/v1/user.json'
      json_payload = JSON.parse payload

      Teamtailor::User.new json_payload.dig('data')
    end

    it { expect(user.id).to eq 34 }
    it { expect(user.login_email).to eq "admin@teamtailor.localhost" }
  end

  describe 'serializing and deserializing' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/user.json'
      json_payload = JSON.parse payload

      user = Teamtailor::User.new json_payload.dig('data')

      deserialized_user = Teamtailor::User.deserialize user.serialize

      expect(user.payload).to eq deserialized_user.payload
    end
  end
end
