# frozen_string_literal: true

require "teamtailor/parser/candidate"

RSpec.describe Teamtailor::Candidate do
  describe "testing getters" do
    let(:job) do
      payload = File.read "spec/fixtures/v1/job.json"
      json_payload = JSON.parse payload

      Teamtailor::Job.new json_payload.dig("data")
    end

    it { expect(job.id).to eq 26 }
    it { expect(job.title).to eq "Ruby on Rails developer" }
    it { expect(job.careersite_job_url).to eq "http://company0.teamtailor.localhost/jobs/26-ruby-on-rails-developer" }
  end

  describe "serializing and deserializing" do
    it "works" do
      payload = File.read "spec/fixtures/v1/job.json"
      json_payload = JSON.parse payload

      candidate = Teamtailor::Job.new json_payload.dig("data")

      deserialized_candidate = Teamtailor::Job.deserialize candidate.serialize

      expect(candidate.payload).to eq deserialized_candidate.payload
    end
  end
end
