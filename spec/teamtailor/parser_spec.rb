# frozen_string_literal: true

require 'teamtailor/parser'

RSpec.describe Teamtailor::Parser do
  context 'parsing a single candidate' do
    it 'parses the response into an array of Teamtailor::Candidate' do
      payload = File.read 'spec/fixtures/v1/candidate.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 1
      expect(result.first.id).to eq 1
    end
  end

  context 'parsing a list of candidates' do
    it 'parses the response into an array of Teamtailor::Candidate' do
      payload = File.read 'spec/fixtures/v1/candidates.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 1
      expect(result.first.id).to eq 1
    end
  end

  context 'parsing a list of jobs' do
    it 'parses the response into an array of Teamtailor::Job' do
      payload = File.read 'spec/fixtures/v1/jobs.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 2
      expect(result.map(&:title)).to include(
        'Ruby on Rails developer',
        'EmberJS Developer'
      )
    end
  end

  context 'getting an unknown record' do
    it 'raises an Teamtailor::UnknownResponseTypeError' do
      payload = { 'id' => 3, 'type' => 'foo' }

      expect do
        Teamtailor::Parser.parse({ 'data' => payload })
      end.to raise_error Teamtailor::UnknownResponseTypeError
    end
  end
end
