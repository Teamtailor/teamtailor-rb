# frozen_string_literal: true

require 'teamtailor/parser/candidate'

RSpec.describe Teamtailor::Candidate do
  describe 'testing getters' do
    let(:candidate) do
      payload = File.read 'spec/fixtures/v1/candidate.json'
      json_payload = JSON.parse payload

      Teamtailor::Candidate.new json_payload.dig('data')
    end

    it { expect(candidate.id).to eq 1 }
    it { expect(candidate.connected?).to eq false }
    it { expect(candidate.first_name).to eq 'Gregoria' }
    it { expect(candidate.last_name).to eq 'Deckow' }
    it { expect(candidate.tags).to eq [] }
    it { expect(candidate.email).to eq 'applicant1@example.com' }
  end

  describe 'serializing and deserializing' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/candidate.json'
      json_payload = JSON.parse payload

      candidate = Teamtailor::Candidate.new json_payload.dig('data')

      deserialized_candidate = Teamtailor::Candidate.deserialize candidate.serialize

      expect(candidate.payload).to eq deserialized_candidate.payload
    end
  end
end
