# frozen_string_literal: true

require_relative '../../lib/unmineable_workers'
require_relative '../support/vcr'

RSpec.describe UnmineableWorkers do
  subject(:workers) { described_class.new(account: account) }

  include_context 'with vcr'

  describe '#all' do
    it { expect(workers.all).to eq(%w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e rig2 rig3 rig4 sg1d sg1a]) }
  end

  describe '#all_online?' do
    it { expect(workers).to be_all_online(%w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e rig2 rig3 rig4 sg1d sg1a]) }
    it { expect(workers).not_to be_all_online(%w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e rig2 rig3 rig4 sg1d]) }
    it { expect(workers).not_to be_all_online(%w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e rig2 rig3 rig4 sg1d sg1a e]) }
  end

  describe '#all_offline' do
    it { expect(workers.all_offline(%w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e rig2 rig3 rig4 sg1d sg1a])).to eq([]) }
    it { expect(workers.all_offline(%w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e rig2 rig3 rig4 sg1d])).to eq([]) }

    specify do
      expect(workers.all_offline(%w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e rig2 rig3 rig4 sg1d sg1a e])).to eq(%w[e])
    end
  end

  describe '#algo' do
    it { expect(workers.algo(:ethash)).to eq(%w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e]) }
    it { expect(workers.algo(:etchash)).to eq([]) }
    it { expect(workers.algo(:randomx)).to eq([]) }
    it { expect(workers.algo(:kawpow)).to eq(%w[rig2 rig3 rig4 sg1d sg1a]) }

    specify 'using unsupported algo' do
      expect { workers.algo(:xxxhash) }.to raise_error(ArgumentError, 'Unsupported algo: xxxhash')
    end
  end

  describe '#algo_online?' do
    it { expect(workers).to be_algo_online(:ethash, %w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e]) }
    it { expect(workers).not_to be_algo_online(:ethash, %w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e additional]) }
    it { expect(workers).not_to be_algo_online(:ethash, %w[rig1 szu01 vol1 aerocool sg1c sg1f]) }

    it { expect(workers).to be_algo_online(:etchash, %w[]) }
    it { expect(workers).not_to be_algo_online(:etchash, %w[etchash1]) }

    it { expect(workers).to be_algo_online(:randomx, %w[]) }
    it { expect(workers).not_to be_algo_online(:randomx, %w[randomx1]) }

    it { expect(workers).to be_algo_online(:kawpow, %w[rig2 rig3 rig4 sg1d sg1a]) }
    it { expect(workers).not_to be_algo_online(:kawpow, %w[rig2 rig3 rig4 sg1d sg1a extra]) }
    it { expect(workers).not_to be_algo_online(:kawpow, %w[rig2 rig3 rig4 sg1d]) }
  end

  describe '#algo_offline' do
    it { expect(workers.algo_offline(:ethash, %w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e])).to eq([]) }
    it { expect(workers.algo_offline(:ethash, %w[rig1 szu01 vol1 aerocool sg1c sg1f])).to eq([]) }
    it { expect(workers.algo_offline(:ethash, %w[rig1 szu01 vol1 aerocool sg1c sg1f sg1e e])).to eq(%w[e]) }

    it { expect(workers.algo_offline(:etchash, [])).to eq([]) }
    it { expect(workers.algo_offline(:etchash, %w[etchash1])).to eq(%w[etchash1]) }

    it { expect(workers.algo_offline(:randomx, [])).to eq([]) }
    it { expect(workers.algo_offline(:randomx, %w[randomx1])).to eq(%w[randomx1]) }

    it { expect(workers.algo_offline(:kawpow, %w[rig2 rig3 rig4 sg1d sg1a])).to eq([]) }
    it { expect(workers.algo_offline(:kawpow, %w[rig2 rig3 rig4 sg1d])).to eq([]) }
    it { expect(workers.algo_offline(:kawpow, %w[rig2 rig3 rig4 sg1d sg1a e])).to eq(%w[e]) }
  end
end
