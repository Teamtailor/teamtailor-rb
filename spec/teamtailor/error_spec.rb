# frozen_string_literal: true

RSpec.describe Teamtailor::Error do
  describe ".from_response" do
    subject(:error) { described_class.from_response(body: body, status: status) }

    let(:error_detail) { "Something went wrong" }
    let(:body) { {errors: [{detail: error_detail}]}.to_json }

    context "when status is 401" do
      let(:status) { 401 }

      it "returns an UnauthorizedRequestError" do
        expect(error).to be_a(Teamtailor::UnauthorizedRequestError)
      end
    end

    context "when status is 406" do
      let(:status) { 406 }

      it "returns an InvalidApiVersionError with message" do
        expect(error).to be_a(Teamtailor::InvalidApiVersionError)
        expect(error.message).to eq(error_detail)
      end
    end

    context "when status is 422" do
      let(:status) { 422 }

      it "returns an UnprocessableEntityError with message" do
        expect(error).to be_a(Teamtailor::UnprocessableEntityError)
        expect(error.message).to eq(error_detail)
      end
    end

    context "when status is 429" do
      let(:status) { 429 }

      it "returns a RateLimitError" do
        expect(error).to be_a(Teamtailor::RateLimitError)
      end
    end

    context "when status is between 400 and 499 (other)" do
      let(:status) { 418 }

      it "returns a ClientError with message" do
        expect(error).to be_a(Teamtailor::ClientError)
        expect(error.message).to eq(error_detail)
      end
    end

    context "when status is between 500 and 599" do
      let(:status) { 500 }

      it "returns a ServerError with message" do
        expect(error).to be_a(Teamtailor::ServerError)
        expect(error.message).to eq(error_detail)
      end
    end

    context "when status is unknown" do
      let(:status) { 300 }

      it "returns an UnknownResponseError with status in message" do
        expect(error).to be_a(Teamtailor::UnknownResponseError)
        expect(error.message).to include("Unexpected error (status: 300)")
      end
    end

    context "when body does not parse as JSON" do
      let(:status) { 422 }
      let(:body) { "not-json" }

      it "defaults error message to Unknown error" do
        expect(error).to be_a(Teamtailor::UnprocessableEntityError)
        expect(error.message).to eq("Unknown error")
      end
    end

    context "when body has a different error structure" do
      let(:status) { 422 }
      let(:body) { {errors: {detail: "Another error"}}.to_json }

      it "uses the alternative error detail" do
        expect(error.message).to eq("Another error")
      end
    end
  end

  describe ".parse_body" do
    subject(:parsed) { described_class.parse_body(body) }

    context "with valid JSON" do
      let(:body) { {test: "ok"}.to_json }

      it "parses and returns the hash" do
        expect(parsed).to eq("test" => "ok")
      end
    end

    context "with invalid JSON" do
      let(:body) { "this is not json" }

      it "returns an empty hash" do
        expect(parsed).to eq({})
      end
    end

    context "with empty string" do
      let(:body) { "" }

      it "returns an empty hash" do
        expect(parsed).to eq({})
      end
    end
  end
end
