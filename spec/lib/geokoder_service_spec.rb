# frozen_string_literal: true

RSpec.describe GeokoderService::Client, type: :client do # rubocop: disable Metrics/BlockLength
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }

  before do
    stubs.post('v1') { [status, headers, body.to_json] }
  end

  describe '#code (valid city)' do
    let(:lat) { 64.7313924 }
    let(:lon) { 177.5015421 }
    let(:body) { { 'lat' => lat, 'lon' => lon } }

    it 'returns user_id' do
      expect(subject.code('valid.city.name')).to eq({ 'lat' => lat, 'lon' => lon })
    end
  end

  describe '#code (invalid city)' do
    let(:status) { 422 }

    it 'returns a nil value' do
      expect(subject.code('invalid.city.name')).to be_nil
    end
  end

  describe '#code (city is nil)' do
    let(:status) { 422 }

    it 'returns a nil value' do
      expect(subject.code(nil)).to be_nil
    end
  end
end
