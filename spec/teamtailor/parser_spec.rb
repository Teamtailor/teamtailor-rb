# frozen_string_literal: true

require 'teamtailor/parser'

RSpec.describe Teamtailor::Parser do
  context 'parsing a company' do
    it 'parses the response into an array of Teamtailor::Company' do
      payload = File.read 'spec/fixtures/v1/company.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 1
      expect(result.first.id).to eq 'foobar'
      expect(result.first.name).to eq 'Teamtailor'
    end
  end

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

  context 'parsing jobs' do
    it 'parses multiple jobs into an array of Teamtailor::Job' do
      payload = File.read 'spec/fixtures/v1/jobs.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 2
      expect(result.map(&:title)).to include(
        'Ruby on Rails developer',
        'EmberJS Developer'
      )
    end

    it 'does not have a loaded user relation' do
      payload = File.read 'spec/fixtures/v1/job.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse(json_payload).first

      expect(result.id).to eq 26
      expect(result.user).not_to be_loaded
    end

    context 'parsing a job with included user' do
      it 'parses into a Teamtailor::Job with a loaded user relation' do
        payload = File.read 'spec/fixtures/v1/job_included_user.json'
        json_payload = JSON.parse payload

        result = Teamtailor::Parser.parse(json_payload).first

        expect(result.id).to eq 26
        expect(result.user).to be_loaded
        expect(result.user.records.size).to eq 1
        expect(result.user.records.first.id).to eq 34
        expect(result.user.records.first.login_email).to eq 'admin@teamtailor.localhost'
      end
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

  context 'parsing a list of users' do
    it 'parses the response into an array of Teamtailor::User' do
      payload = File.read 'spec/fixtures/v1/users.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 2
      expect(result.map(&:login_email)).to include(
        'email29@example.com',
        'admin@teamtailor.localhost'
      )
    end
  end

  context 'parsing job applications' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/job_applications.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 2
      expect(result.map(&:id)).to include(634, 635)
    end
  end

  context 'parsing stages' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/stages.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 3
      expect(result.map(&:id)).to include(1, 2, 5)
    end
  end

  context 'parsing reject reasons' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/reject_reasons.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 10
      expect(result.map(&:id)).to include(1, 2, 5)
    end
  end

  context 'parsing departments' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/departments.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 2
      expect(result.map(&:id)).to include(1, 2)
      expect(result.map(&:name)).to include('Product Development', 'Sales')
    end
  end

  context 'parsing locations' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/locations.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 1
      expect(result.map(&:id)).to include(1)
      expect(result.map(&:name)).to include('Stockholm')
    end
  end

  context 'parsing custom fields' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/custom-fields.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 3
      expect(result.map(&:id)).to include(1, 2, 3)
      expect(result.map(&:name)).to include('Drivers license?', 'Github profile', 'Favorite programming language')
      expect(result.map(&:api_name)).to include('drivers-license', 'github-profile', 'favorite-programming-language')
      expect(result.map(&:field_type)).to include('CustomField::Checkbox', 'CustomField::Url', 'CustomField::MultiSelect')
    end
  end

  context 'parsing custom field values' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/custom-field-values.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 1
      expect(result.map(&:field_type)).to include('CustomField::Url')
      expect(result.map(&:value)).to include('https://github.com/bzf')
    end
  end

  context 'parsing referrals' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/referrals.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 1
      expect(result.first.comment).to eq "Enthusiastic human being that deserves the job!"
      expect(result.first.name).to eq "Jenn Doe"
      expect(result.first.phone).to be_nil
    end
  end

  context 'parsing referrals' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/partner-results.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 1
      expect(result.first.partner_name).to eq "Partner 2"
      expect(result.first.status).to eq "completed"
      expect(result.first.url).to be_nil
    end
  end

  context 'parsing requisitions' do
    it 'works' do
      payload = File.read 'spec/fixtures/v1/requisitions.json'
      json_payload = JSON.parse payload

      result = Teamtailor::Parser.parse json_payload

      expect(result.size).to eq 1
      expect(result.first.job_title).to eq "Backend developer"
      expect(result.first.job_description).to eq "We need someone to refactor our API endpoints"
      expect(result.first.custom_form_answers).to eq({
        "division" => "Europe",
        "comments" => "We should make sure that the applicant is familiar with the Go programming language"
      })
    end

    context "with included requisition-step-verdicts" do
      it "works" do
        payload = File.read 'spec/fixtures/v1/requisitions-with-verdicts.json'
        json_payload = JSON.parse payload

        result = Teamtailor::Parser.parse json_payload

        expect(result.size).to eq 1
        expect(result.first.job_title).to eq "Backend developer"
        expect(result.first.job_description).to eq "We need someone to refactor our API endpoints"
        expect(result.first.requisition_step_verdicts).to be_loaded

        records = result.first.requisition_step_verdicts.records
        expect(records.size).to eq 2
        expect(records.find { |r| r.id == 1 }.status).to eq "approved"
        expect(records.find { |r| r.id == 1 }.requisition_step_index).to eq 0
        expect(records.find { |r| r.id == 2 }.status).to eq "pending"
        expect(records.find { |r| r.id == 2 }.requisition_step_index).to eq 1
      end

      context "with nested user" do
        it "works" do
          payload = File.read 'spec/fixtures/v1/requisition-with-step-verdicts-with-user.json'
          json_payload = JSON.parse payload

          result = Teamtailor::Parser.parse json_payload

          expect(result.size).to eq 1
          expect(result.first.requisition_step_verdicts).to be_loaded
          records = result.first.requisition_step_verdicts.records
          expect(records.size).to eq 1
          expect(records.first.status).to eq "pending"

          expect(records.first.user).to be_loaded
          expect(records.first.user.records.size).to eq 1
          user = records.first.user.records.first
          expect(user.id).to eq 4
          expect(user.login_email).to eq "admin@teamtailor.localhost"
        end
      end
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
