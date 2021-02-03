# frozen_string_literal: true

module Teamtailor
  class Relationship
    def initialize(relation_name, relationships = {}, included = {})
      @relation_name = relation_name
      @relationships = relationships
      @included = included
    end

    def loaded?
      !record_ids.empty?
    end

    def records
      raise Teamtailor::UnloadedRelationError unless loaded?

      record_json = included.select do |k|
        record_ids.include?(k["id"]) && k["type"] == record_type
      end

      Teamtailor::Parser.parse({ "data" => record_json, "included" => included })
    end

    private

    def record_ids
      data = [relationships&.dig(relation_name, "data")].flatten.compact
      data.map { |row| row["id"] }
    end

    def record_type
      data = [relationships&.dig(relation_name, "data")].flatten
      data.map { |row| row["type"] }.first
    end

    attr_reader :relation_name, :relationships, :included
  end
end
