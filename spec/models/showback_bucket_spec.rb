require 'spec_helper'
require 'money-rails/test_helpers'

RSpec.describe ManageIQ::Consumption::ShowbackBucket, :type => :model do
  let(:bucket) { FactoryGirl.build(:showback_bucket) }
  let(:event) { FactoryGirl.build(:showback_event) }

=begin
  describe '#basic lifecycle' do
    it 'has a valid factory' do
      bucket.valid?
      expect(bucket).to be_valid
    end

    it 'is not valid without an association to a parent element' do
      bucket.resource = nil
      bucket.valid?
      expect(bucket.errors.details[:resource]). to include(:error => :blank)
    end

    it 'is not valid without a name' do
      bucket.name = nil
      bucket.valid?
      expect(bucket.errors.details[:name]). to include(:error => :blank)
    end

    it 'is not valid without a description' do
      bucket.description = nil
      bucket.valid?
      expect(bucket.errors.details[:description]). to include(:error => :blank)
    end

    it 'deletes costs associated when deleting the bucket' do
      FactoryGirl.create(:showback_charge, :showback_bucket => bucket)
      FactoryGirl.create(:showback_charge, :showback_bucket => bucket)
      expect(bucket.showback_charges.count).to be(2)
      expect { bucket.destroy }.to change(ShowbackCharge, :count).from(2).to(0)
    end

    it 'deletes costs associated when deleting the event' do
      FactoryGirl.create(:showback_charge, :showback_bucket => bucket)
      FactoryGirl.create(:showback_charge, :showback_bucket => bucket)
      expect(bucket.showback_charges.count).to be(2)
      event = bucket.showback_charges.first.showback_event
      expect { event.destroy }.to change(ShowbackCharge, :count).from(2).to(1)
    end

    it 'it can  be on states open, processing, close' do
      bucket.state = "ERROR"
      expect(bucket).not_to be_valid
      expect(bucket.errors[:state]).to include "is not included in the list"
    end

    it 'it can not be different of states open, processing, close' do
      bucket.state = "CLOSE"
      expect(bucket).to be_valid
    end

    context ".control lifecycle state" do
      before(:each) do
        @bucket_lifecycle = FactoryGirl.create(:showback_bucket)
      end

      it 'it can transition from open to processing' do
        @bucket_lifecycle.state = "PROCESSING"
        expect { @bucket_lifecycle.save }.not_to raise_error
      end

      it 'a new bucket is created automatically when transitioning from open to processing if not exists' do
        @bucket_lifecycle.state = "PROCESSING"
        @bucket_lifecycle.save
        expect(ShowbackBucket.count).to eq(1)
      end

      it 'it can not transition from open to closed' do
        @bucket_lifecycle.state = "CLOSE"
        expect { @bucket_lifecycle.save }.to raise_error(RuntimeError, "Bucket can't change its state to CLOSE from OPEN")
      end

      it 'it can not transition from processing to open' do
        @bucket_lifecycle = FactoryGirl.create(:showback_bucket_processing)
        @bucket_lifecycle.state = "OPEN"
        expect { @bucket_lifecycle.save }.to raise_error(RuntimeError, "Bucket can't change its state to OPEN from PROCESSING")
      end

      it 'it can transition from processing to closed' do
        @bucket_lifecycle = FactoryGirl.create(:showback_bucket_processing)
        @bucket_lifecycle.state = "CLOSE"
        expect { @bucket_lifecycle.save }.not_to raise_error
      end

      it 'it can not transition from closed to open or processing' do
        @bucket_lifecycle = FactoryGirl.create(:showback_bucket_close)
        @bucket_lifecycle.state = "OPEN"
        expect { @bucket_lifecycle.save }.to raise_error(RuntimeError, "Bucket can't change its state when it's CLOSE")
        @bucket_lifecycle = FactoryGirl.create(:showback_bucket_close)
        @bucket_lifecycle.state = "PROCESSING"
        expect { @bucket_lifecycle.save }.to raise_error(RuntimeError, "Bucket can't change its state when it's CLOSE")
      end
    end

    pending 'it can not exists 2 buckets opened from one resource'
  end

  describe '#state:open' do
    it 'new events can be associated to the bucket' do
      bucket.save
      event.save
      expect { bucket.showback_events << event }.to change(bucket.showback_events, :count).by(1)
      expect(bucket.showback_events.last).to eq(event)
    end

    it 'events can be associated to costs' do
      bucket.save
      event.save
      expect { bucket.showback_events << event }.to change(bucket.showback_charges, :count).by(1)
      charge = bucket.showback_charges.last
      expect(charge.showback_event).to eq(event)
      expect { charge.cost = Money.new(3) }.to change(charge, :cost).from(0).to(Money.new(3))
    end

    it 'monetized cost' do
      expect(ShowbackCharge).to monetize(:cost)
    end

    pending 'charges can be updated for an event'
    pending 'charges can be updated for all events in the bucket'
    pending 'charges can be deleted for an event'
    pending 'charges can be deleted for all events in the bucket'
    pending 'is possible to return charges for an event'
    pending 'is possible to return charges for all events'
    pending 'sum of charges can be calculated for the bucket'
    pending 'sum of charges can be calculated for an event type'
  end
=end

  describe '#state:processing' do
    pending 'new events are associated to a new or open bucket'
    pending 'new events can not be associated to the bucket'
    pending 'charges can be deleted for an event'
    pending 'charges can be deleted for all events in the bucket'
    pending 'charges can be updated for an event'
    pending 'charges can be updated for all events in the bucket'
    pending 'is possible to return charges for an event'
    pending 'is possible to return charges for all events'
    pending 'sum of charges can be calculated for the bucket'
    pending 'sum of charges can be calculated for an event type'
  end

  describe '#state:closed' do
    pending 'new events can not be associated to the bucket'
    pending 'new events are associated to a new or existing open bucket'
    pending 'charges can not be deleted for an event'
    pending 'charges can not be deleted for all events in the bucket'
    pending 'charges can not be updated for an event'
    pending 'charges can not be updated for all events in the bucket'
    pending 'is possible to return charges for an event'
    pending 'is possible to return charges for all events'
    pending 'sum of charges can be calculated for the bucket'
    pending 'sum of charges can be calculated for an event type'
  end
end