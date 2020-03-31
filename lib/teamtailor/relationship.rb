# frozen_string_literal: true

module Teamtailor
  class Relationship
    def initialize(relation_name, relationships = {}, included = {})
      @relation_name = relation_name
      @relationships = relationships
      @included = included
    end

    def loaded?
      !record_id.nil?
    end

    def record
      raise Teamtailor::UnloadedRelationError unless loaded?

      record_json = included.find do |k|
        k['id'] == record_id && k['type'] == record_type
      end

      Teamtailor::Parser.parse({ 'data' => record_json }).first
    end

    private

    def record_id
      relationships&.dig(relation_name, 'data', 'id')
    end

    def record_type
      relationships&.dig(relation_name, 'data', 'type')
    end

    attr_reader :relation_name, :relationships, :included
  end
end
