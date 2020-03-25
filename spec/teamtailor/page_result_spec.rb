# frozen_string_literal: true

require 'teamtailor/page_result'

RSpec.describe Teamtailor::PageResult do
  context 'when getting a single response back' do
    let(:page_result) do
      @response = File.read 'spec/fixtures/v1/candidates.json'
      Teamtailor::PageResult.new @response
    end

    it { expect(page_result.page_count).to eq 1 }
    it { expect(page_result.record_count).to eq 1 }
    it { expect(page_result.next_page_url).to be_nil }

    it do
      expect(page_result.first_page_url).to eq(
        'http://api.teamtailor.localhost/v1/candidates?page%5Bnumber%5D=1&page%5Bsize%5D=10'
      )
    end

    it do
      expect(page_result.last_page_url).to eq(
        'http://api.teamtailor.localhost/v1/candidates?page%5Bnumber%5D=41&page%5Bsize%5D=10'
      )
    end

    describe '#data' do
      it 'returns an the data attribute of the response' do
        expect(page_result.data).to eq JSON.parse(@response).dig('data')
      end
    end

    describe '#records' do
      it 'returns an array of parsed records' do
        expect(Teamtailor::Parser).to receive(:parse).and_call_original

        result = page_result.records

        expect(result.size).to eq 1
        expect(result.map(&:class).compact).to eq [Teamtailor::Candidate]
      end
    end
  end

  context 'getting an invalid JSON response' do
    it 'raises an Teamtailor::JSONError' do
      expect do
        Teamtailor::PageResult.new 'totally-not-json'
      end.to(raise_error { Teamtailor::JSONError })
    end
  end
end
