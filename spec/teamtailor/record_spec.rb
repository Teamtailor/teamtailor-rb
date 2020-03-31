# frozen_string_literal: true

require 'teamtailor/record'

RSpec.describe Teamtailor::Record do
  it 'returns #id as a number' do
    record_id = Random.rand(100)
    record = Teamtailor::Record.new(
      'id' => record_id.to_s
    )

    expect(record.id).to eq record_id
  end

  describe 'attributes' do
    it 'responds to attribute names' do
      record = Teamtailor::Record.new(
        'attributes' => {
          'name' => 'Eminem'
        }
      )

      expect(record.name).to eq 'Eminem'
    end

    it 'responds to underscore versions of a attribute' do
      record = Teamtailor::Record.new('attributes' => { 'first-name' => 'Frej' })

      expect(record.first_name).to eq 'Frej'
    end
  end

  describe 'non-loaded relationships' do
    it 'returns unloaded relations' do
      record = Teamtailor::Record.new('relationships' => { 'user' => {} })

      relation = record.user
      expect(relation).not_to be_loaded
    end
  end

  describe 'loaded relationships' do
    it 'returns loaded relations' do
      user_id = Random.rand 100
      record = Teamtailor::Record.new(
        {
          'attributes' => {
            'value' => 42
          },
          'relationships' => {
            'user' => {
              'data' => {
                'id' => user_id,
                'type' => 'users'
              }
            }
          }
        },
        [
          {
            'id' => user_id,
            'type' => 'users',
            'attributes' => {
              'name' => 'Marshall Mathers'
            }
          }
        ]
      )

      expect(record.value).to eq 42
      relation = record.user
      expect(relation).to be_loaded
      expect(relation.record.name).to eq 'Marshall Mathers'
    end
  end
end
