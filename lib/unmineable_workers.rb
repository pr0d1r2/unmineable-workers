# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

# List workers on unmineable account
class UnmineableWorkers
  HOST = 'api.unminable.com'
  VERSION = 'v4'
  ALGOS = %w[ethash etchash randomx kawpow].freeze

  attr_reader :account

  def initialize(account:)
    @account = account
  end

  def all
    ALGOS.map { |alg| algo(alg) }.flatten
  end

  def all_online?(expected_hosts)
    all == expected_hosts
  end

  def all_offline(expected_hosts)
    expected_hosts - all
  end

  def algo(name)
    raise ArgumentError, "Unsupported algo: #{name}" unless ALGOS.include?(name.to_s)

    data[name.to_s]['workers'].select { |worker| worker['online'] == true }.map { |worker| worker['name'] }
  end

  def algo_online?(name, expected_hosts)
    algo(name) == expected_hosts
  end

  def algo_offline(name, expected_hosts)
    expected_hosts - algo(name)
  end

  private

  def data
    @data = json['data']
  end

  def json
    JSON.parse(body)
  end

  def body
    response.body if response.is_a?(Net::HTTPSuccess)
  end

  def response
    @response ||= Net::HTTP.get_response(uri)
  end

  def uri
    URI(endpoint)
  end

  def endpoint
    "https://#{HOST}/#{VERSION}/account/#{account}/workers"
  end
end
