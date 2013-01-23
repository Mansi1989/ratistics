require 'spec_helper'

module Ratistics
  describe ProbabilityMassFunction do

    context '#frequency' do

      it 'returns nil for a nil sample' do
        ProbabilityMassFunction.frequency(nil).should be_nil 
      end

      it 'returns nil for an empty sample' do
        ProbabilityMassFunction.frequency([].freeze).should be_nil 
      end

      it 'returns a one-element hash for a one-item sample' do
        sample = [10].freeze
        frequency = ProbabilityMassFunction.frequency(sample)
        frequency.should == {10 => 1}
      end

      it 'returns a multi-element hash for a multi-element sample' do
        sample = [13, 18, 13, 14, 13, 16, 14, 21, 13].freeze

        frequency = ProbabilityMassFunction.frequency(sample)

        frequency.count.should eq 5
        frequency[13].should eq 4
        frequency[14].should eq 2
        frequency[16].should eq 1
        frequency[18].should eq 1
        frequency[21].should eq 1
      end

      it 'returns a one-element hash for a one-item sample with a block' do
        sample = [
          {:count => 10},
        ].freeze

        frequency = ProbabilityMassFunction.frequency(sample){|item| item[:count]}
        frequency.should == {10 => 1}
      end

      it 'returns a multi-element hash for a multi-element sample with a block' do
        sample = [
          {:count => 13},
          {:count => 18},
          {:count => 13},
          {:count => 14},
          {:count => 13},
          {:count => 16},
          {:count => 14},
          {:count => 21},
          {:count => 13},
        ].freeze

        frequency = ProbabilityMassFunction.frequency(sample){|item| item[:count]}

        frequency.count.should eq 5
        frequency[13].should eq 4
        frequency[14].should eq 2
        frequency[16].should eq 1
        frequency[18].should eq 1
        frequency[21].should eq 1
      end

      context 'with Hamster' do

        let(:list) { Hamster.list(13, 18, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:vector) { Hamster.vector(13, 18, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:set) { Hamster.set(13, 18, 14, 16, 21).freeze }

        specify do
          frequency = ProbabilityMassFunction.frequency(list)

          frequency.count.should eq 5
          frequency[13].should eq 4
          frequency[14].should eq 2
          frequency[16].should eq 1
          frequency[18].should eq 1
          frequency[21].should eq 1
        end

        specify do
          frequency = ProbabilityMassFunction.frequency(vector)

          frequency.count.should eq 5
          frequency[13].should eq 4
          frequency[14].should eq 2
          frequency[16].should eq 1
          frequency[18].should eq 1
          frequency[21].should eq 1
        end

        specify do
          frequency = ProbabilityMassFunction.frequency(set)

          frequency.count.should eq 5
          frequency[13].should eq 1
          frequency[14].should eq 1
          frequency[16].should eq 1
          frequency[18].should eq 1
          frequency[21].should eq 1
        end
      end
    end

    context '#probability' do

      it 'returns nil for a nil sample' do
        ProbabilityMassFunction.probability(nil).should be_nil 
      end

      it 'returns nil for an empty sample' do
        ProbabilityMassFunction.probability([].freeze).should be_nil 
      end

      it 'returns a one-element hash for a one-item sample' do
        sample = [10].freeze
        probability = ProbabilityMassFunction.probability(sample)
        probability.should == {10 => 1}
      end

      it 'returns a multi-element hash for a multi-element sample' do
        sample = [13, 18, 13, 14, 13, 16, 14, 21, 13].freeze

        probability = ProbabilityMassFunction.probability(sample)

        probability.count.should eq 5
        probability[13].should be_within(0.01).of(0.444)
        probability[14].should be_within(0.01).of(0.222) 
        probability[16].should be_within(0.01).of(0.111) 
        probability[18].should be_within(0.01).of(0.111) 
        probability[21].should be_within(0.01).of(0.111) 
      end

      it 'returns a one-element hash for a one-item sample with a block' do
        sample = [
          {:count => 10},
        ].freeze

        probability = ProbabilityMassFunction.probability(sample){|item| item[:count]}
        probability.should == {10 => 1}
      end

      it 'returns a multi-element hash for a multi-element sample with a block' do
        sample = [
          {:count => 13},
          {:count => 18},
          {:count => 13},
          {:count => 14},
          {:count => 13},
          {:count => 16},
          {:count => 14},
          {:count => 21},
          {:count => 13},
        ].freeze

        probability = ProbabilityMassFunction.probability(sample){|item| item[:count]}

        probability.count.should eq 5
        probability[13].should be_within(0.01).of(0.444)
        probability[14].should be_within(0.01).of(0.222) 
        probability[16].should be_within(0.01).of(0.111) 
        probability[18].should be_within(0.01).of(0.111) 
        probability[21].should be_within(0.01).of(0.111) 
      end

      context 'with Hamster' do

        let(:list) { Hamster.list(13, 18, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:vector) { Hamster.vector(13, 18, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:set) { Hamster.set(13, 18, 14, 16, 21).freeze }

        specify do
          probability = ProbabilityMassFunction.probability(list)

          probability.count.should eq 5
          probability[13].should be_within(0.01).of(0.444)
          probability[14].should be_within(0.01).of(0.222) 
          probability[16].should be_within(0.01).of(0.111) 
          probability[18].should be_within(0.01).of(0.111) 
          probability[21].should be_within(0.01).of(0.111) 
        end

        specify do
          probability = ProbabilityMassFunction.probability(vector)

          probability.count.should eq 5
          probability[13].should be_within(0.01).of(0.444)
          probability[14].should be_within(0.01).of(0.222) 
          probability[16].should be_within(0.01).of(0.111) 
          probability[18].should be_within(0.01).of(0.111) 
          probability[21].should be_within(0.01).of(0.111) 
        end

        specify do
          probability = ProbabilityMassFunction.probability(set)

          probability.count.should eq 5
          probability[13].should be_within(0.01).of(0.2)
          probability[14].should be_within(0.01).of(0.2) 
          probability[16].should be_within(0.01).of(0.2) 
          probability[18].should be_within(0.01).of(0.2) 
          probability[21].should be_within(0.01).of(0.2) 
        end

      end
    end

    context '#probability_mean' do

      it 'returns zero for a nil sample' do
        ProbabilityMassFunction.probability_mean(nil).should eq 0
      end

      it 'returns zero for an empty sample' do
        ProbabilityMassFunction.probability_mean([]).should eq 0
      end

      it 'calculates the mean for a one-element sample' do
        sample = [1].freeze
        mean = ProbabilityMassFunction.probability_mean(sample)
        mean.should be_within(0.01).of(1.0)
      end

      it 'calculates the mean for a multi-element sample' do
        sample = [1, 2, 3, 4, 5, 6, 6, 6, 6, 6].freeze
        mean = ProbabilityMassFunction.probability_mean(sample)
        mean.should be_within(0.01).of(4.5)
      end

      it 'calculates the mean for a sample with a block' do
        sample = [
          {:count => 1},
          {:count => 2},
          {:count => 3},
          {:count => 4},
          {:count => 5},
          {:count => 6},
          {:count => 6},
          {:count => 6},
          {:count => 6},
          {:count => 6},
        ].freeze

        mean = ProbabilityMassFunction.probability_mean(sample){|item| item[:count]}
        mean.should be_within(0.01).of(4.5)
      end

      context 'with Hamster' do

        let(:list) { Hamster.list(1, 2, 3, 4, 5, 6, 6, 6, 6, 6).freeze }
        let(:vector) { Hamster.vector(1, 2, 3, 4, 5, 6, 6, 6, 6, 6).freeze }
        let(:set) { Hamster.set(1, 2, 3, 4, 5, 6).freeze }

        specify do
          mean = ProbabilityMassFunction.probability_mean(list)
          mean.should be_within(0.01).of(4.5)
        end

        specify do
          mean = ProbabilityMassFunction.probability_mean(vector)
          mean.should be_within(0.01).of(4.5)
        end

        specify do
          mean = ProbabilityMassFunction.probability_mean(set)
          mean.should be_within(0.01).of(3.5)
        end
      end
    end

    context '#probability_variance' do

      it 'returns zero for a nil sample' do
        ProbabilityMassFunction.probability_variance(nil).should eq 0
      end

      it 'returns zero for an empty sample' do
        ProbabilityMassFunction.probability_variance([]).should eq 0
      end

      it 'calculates the variance for a one-element sample' do
        sample = [1].freeze
        variance = ProbabilityMassFunction.probability_variance(sample)
        variance.should be_within(0.01).of(0.0)
      end

      it 'calculates the variance for a multi-element sample' do
        sample = [1, 2, 3, 4, 5, 6, 6, 6, 6, 6].freeze
        variance = ProbabilityMassFunction.probability_variance(sample)
        variance.should be_within(0.01).of(3.25)
      end

      it 'calculates the variance for a sample with a block' do
        sample = [
          {:count => 1},
          {:count => 2},
          {:count => 3},
          {:count => 4},
          {:count => 5},
          {:count => 6},
          {:count => 6},
          {:count => 6},
          {:count => 6},
          {:count => 6},
        ].freeze

        variance = ProbabilityMassFunction.probability_variance(sample){|item| item[:count]}
        variance.should be_within(0.01).of(3.25)
      end

      context 'with Hamster' do

        let(:list) { Hamster.list(1, 2, 3, 4, 5, 6, 6, 6, 6, 6).freeze }
        let(:vector) { Hamster.vector(1, 2, 3, 4, 5, 6, 6, 6, 6, 6).freeze }
        let(:set) { Hamster.set(1, 2, 3, 4, 5, 6).freeze }

        specify do
          mean = ProbabilityMassFunction.probability_variance(list)
          mean.should be_within(0.01).of(3.25)
        end

        specify do
          mean = ProbabilityMassFunction.probability_variance(vector)
          mean.should be_within(0.01).of(3.25)
        end

        specify do
          mean = ProbabilityMassFunction.probability_variance(set)
          mean.should be_within(0.01).of(2.91)
        end
      end
    end
  end
end
