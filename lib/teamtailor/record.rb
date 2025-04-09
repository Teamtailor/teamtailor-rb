require "teamtailor/relationship"

module Teamtailor
  class Record
    def initialize(data, included = {})
      @data = data
      @included = included
    end

    def self.deserialize(value)
      payload = JSON.parse value
      new(payload["data"], payload["included"])
    end

    def serialize
      {
        data: data,
        included: included
      }.to_json
    end

    def method_missing(m)
      if m == :id
        data.dig("id").to_i
      elsif relationship_keys.include?(m.to_s.tr("_", "-"))
        build_relationship(m.to_s.tr("_", "-"))
      else
        data.dig("attributes", m.to_s.tr("_", "-"))
      end
    end

    def respond_to_missing?(m, include_private = false)
      m == :id || relationship_keys.include?(m.to_s.tr("_", "-")) || data.dig("attributes")&.key?(m.to_s.tr("_", "-")) || super
    end

    private

    attr_reader :data, :included

    def build_relationship(name)
      Teamtailor::Relationship.new(name, data.dig("relationships"), included)
    end

    def relationship_keys
      data.dig("relationships")&.keys || {}
    end
  end
end
