module Teamtailor
  class Record
    def initialize(data, included = {})
      @data = data
      @included = included
    end

    def method_missing(m)
      if m == :id
        data.dig('id').to_i
      elsif relationship_keys.include?(m.to_s.gsub('_', '-'))
        build_relationship(m.to_s.gsub('_', '-'))
      else
        data.dig('attributes', m.to_s.gsub('_', '-'))
      end
    end

    private

    attr_reader :data, :included

    def build_relationship(name)
      Teamtailor::Relationship.new(name, data.dig('relationships'), included)
    end

    def relationship_keys
      data.dig('relationships')&.keys || {}
    end
  end
end
