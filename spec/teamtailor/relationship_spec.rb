# frozen_string_literal: true

require 'teamtailor/relationship'

RSpec.describe Teamtailor::Relationship do
  describe '#record' do
    context 'when not loaded' do
      subject { Teamtailor::Relationship.new('user') }

      it { expect(subject).not_to be_loaded }

      it 'raises an Teamtailor::UnloadedRelationError' do
        expect do
          subject.record
        end.to raise_error Teamtailor::UnloadedRelationError
      end
    end
  end
end
