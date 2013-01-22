require 'spec_helper'

module Ratistics
  describe Distribution do

    context '#variance' do

      it 'calculates variance around the mean for a sample' do
        sample = [67, 72, 85, 93, 98]
        variance = Distribution.variance(sample)
        variance.should be_within(0.01).of(141.2)
      end

    end

    context '#range' do

      it 'returns zero for an empty list' do
        sample = []
        Distribution.range(sample).should eq 0
      end

      it 'returns zero for a one-element list' do
        sample = [1]
        Distribution.range(sample).should eq 0
      end

      it 'returns the range for a sorted list' do
        sample = [13, 13, 13, 13, 14, 14, 16, 18, 21]
        range = Distribution.range(sample, true)
        range.should be_within(0.01).of(8.0)
      end

      it 'returns the range for an unsorted list' do
        sample = [13, 18, 13, 14, 13, 16, 14, 21, 13]
        range = Distribution.range(sample, false)
        range.should be_within(0.01).of(8.0)
      end

      it 'does not re-sort a sorted list' do
        sample = [13, 13, 13, 13, 14, 14, 16, 18, 21]
        sample.should_not_receive(:sort)
        sample.should_not_receive(:sort_by)
        Distribution.range(sample, true)
      end

      it 'calculates the range when using a block' do
        sample = [
          {:count => 13},
          {:count => 13},
          {:count => 13},
          {:count => 13},
          {:count => 14},
          {:count => 14},
          {:count => 16},
          {:count => 18},
          {:count => 21},
        ]

        range = Distribution.range(sample) {|item| item[:count] }
        range.should be_within(0.01).of(8.0)
      end

      it 'does not attempt to sort when a using a block' do
        sample = [
          {:count => 2},
        ]

        sample.should_not_receive(:sort)
        sample.should_not_receive(:sort_by)

        Distribution.range(sample, false) {|item| item[:count] }
      end
    end
  end
end
