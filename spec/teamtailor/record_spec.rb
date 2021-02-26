# frozen_string_literal: true

require "teamtailor/record"

RSpec.describe Teamtailor::Record do
  it "returns #id as a number" do
    record_id = Random.rand(100)
    record = Teamtailor::Record.new(
      "id" => record_id.to_s
    )

    expect(record.id).to eq record_id
  end

  describe "attributes" do
    it "responds to attribute names" do
      record = Teamtailor::Record.new(
        "attributes" => {
          "name" => "Eminem",
        }
      )

      expect(record.name).to eq "Eminem"
    end

    it "responds to underscore versions of a attribute" do
      record = Teamtailor::Record.new("attributes" => { "first-name" => "Frej" })

      expect(record.first_name).to eq "Frej"
    end
  end

  describe "serializing" do
    it "works" do
      payload = File.read "spec/fixtures/v1/candidate.json"
      json_payload = JSON.parse payload

      candidate = Teamtailor::Record.new json_payload.dig("data")

      deserialized_candidate = Teamtailor::Record.deserialize candidate.serialize

      expect(candidate.payload).to eq deserialized_candidate.payload
      expect(candidate.id).to eq deserialized_candidate.id
    end
  end

  describe "non-loaded relationships" do
    it "returns unloaded relations" do
      record = Teamtailor::Record.new("relationships" => { "user" => {} })

      relation = record.user
      expect(relation).not_to be_loaded
    end
  end

  describe "loaded relationships" do
    it "returns loaded relations" do
      user_id = Random.rand 100
      record = Teamtailor::Record.new(
        {
          "attributes" => {
            "value" => 42,
          },
          "relationships" => {
            "user" => {
              "data" => {
                "id" => user_id,
                "type" => "users",
              },
            },
          },
        },
        [
          {
            "id" => user_id,
            "type" => "users",
            "attributes" => {
              "name" => "Marshall Mathers",
            },
          },
        ]
      )

      expect(record.value).to eq 42
      relation = record.user
      expect(relation).to be_loaded
      expect(relation.records.first.name).to eq "Marshall Mathers"
    end

    describe "serializing" do
      it "works" do
        payload = File.read "spec/fixtures/v1/job_application_included_candidate_job.json"
        json_payload = JSON.parse payload

        job_application = Teamtailor::Record.new(
          json_payload.dig("data"),
          json_payload.dig("included")
        )
        expect(job_application.candidate).to be_loaded
        expect(job_application.candidate.records.first.id).to eq 410
        expect(job_application.job).to be_loaded
        expect(job_application.job.records.first.id).to eq 26

        deserialized_job_application =
          Teamtailor::Record.deserialize(job_application.serialize)
        expect(job_application.payload).to eq deserialized_job_application.payload

        expect(deserialized_job_application.candidate).to be_loaded
        expect(deserialized_job_application.candidate.records.first.id).to eq 410
        expect(deserialized_job_application.job).to be_loaded
        expect(deserialized_job_application.job.records.first.id).to eq 26
      end
    end
  end
end
