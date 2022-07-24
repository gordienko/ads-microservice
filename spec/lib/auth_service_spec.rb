# frozen_string_literal: true

RSpec.describe AuthService::Client, type: :client do # rubocop: disable Metrics/BlockLength
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }

  before do
    stubs.post('auth/v1') { [status, headers, body.to_json] }
  end

  describe '#auth (valid token)' do
    let(:user_id) { 101 }
    let(:body) { { 'data' => { 'id' => user_id } } }

    it 'returns user_id' do
      expect(subject.auth('valid.token')).to eq(user_id)
    end
  end

  describe '#auth (invalid token)' do
    let(:status) { 403 }

    it 'returns a nil value' do
      expect(subject.auth('invalid.token')).to be_nil
    end
  end

  describe '#auth (token is nil)' do
    let(:status) { 403 }

    it 'returns a nil value' do
      expect(subject.auth(nil)).to be_nil
    end
  end
end
