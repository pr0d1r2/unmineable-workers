# frozen_string_literal: true

require 'rubygems'
require 'rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end

RSpec.shared_context 'with vcr' do
  let(:account) { 'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee' }

  around do |example|
    VCR.use_cassette(account, erb: { account: account }) do
      example.run
    end
  end
end
