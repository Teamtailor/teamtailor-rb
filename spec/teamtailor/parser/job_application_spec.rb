# frozen_string_literal: true

require 'teamtailor/parser/job_application'

RSpec.describe Teamtailor::JobApplication do
  describe 'serializing and deserializing' do
    context 'with included relationships' do
      it 'works' do
        payload = File.read 'spec/fixtures/v1/job_application_included_candidate_job.json'
        json_payload = JSON.parse payload

        job_application = Teamtailor::JobApplication.new(
          json_payload.dig('data'),
          json_payload.dig('included')
        )
        expect(job_application.candidate).to be_loaded
        expect(job_application.candidate.record.id).to eq 410
        expect(job_application.job).to be_loaded
        expect(job_application.job.record.id).to eq 26

        deserialized_job_application =
          Teamtailor::JobApplication.deserialize(job_application.serialize)
        expect(job_application.payload).to eq deserialized_job_application.payload

        expect(deserialized_job_application.candidate).to be_loaded
        expect(deserialized_job_application.candidate.record.id).to eq 410
        expect(deserialized_job_application.job).to be_loaded
        expect(deserialized_job_application.job.record.id).to eq 26
      end
    end
  end
end
