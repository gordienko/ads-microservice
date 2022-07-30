# frozen_string_literal: true

RSpec.describe Ads::CreateService do # rubocop: disable Metrics/BlockLength
  subject { described_class }

  let(:user_id) { 101 }
  let(:coordinates) { { 'lat' => 64.7313924, 'lon' => 177.5015421 } }

  context 'valid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City'
      }
    end

    it 'creates a new ad' do
      expect { subject.call(ad: ad_params, user_id: user_id, coordinates: coordinates) }
        .to change { Ad.count }.from(0).to(1)
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id, coordinates: coordinates)

      expect(result.ad).to be_kind_of(Ad)
    end

    # it 'enqueues geocoding job' do
    #   ActiveJob::Base.queue_adapter = :test
    #   subject.call(ad: ad_params, user_id: user_id)
    #
    #   expect(Ads::GeocodingJob).to have_been_enqueued.with(kind_of(Ad))
    # end
  end

  context 'invalid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: ''
      }
    end

    it 'does not create ad' do
      expect { subject.call(ad: ad_params, user_id: user_id, coordinates: coordinates) }
        .not_to change(Ad, :count)
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id, coordinates: coordinates)

      expect(result.ad).to be_kind_of(Ad)
    end

    # it 'does not enqueue geocoding job' do
    #   ActiveJob::Base.queue_adapter = :test
    #   subject.call(ad: ad_params, user_id: user_id)
    #
    #   expect(Ads::GeocodingJob).not_to have_been_enqueued
    # end
  end
end
