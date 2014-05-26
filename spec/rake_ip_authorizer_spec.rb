lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rack/test'
require 'minitest/autorun'
require 'rack/ip_authorizer'

class Rails
  def self.env
  end
end

class IpAuthorizerTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    inner_app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['Hello']] }
    Rack::IpAuthorizer.new(inner_app, {'test' => ['1.1.1.1', '1.1.1.2'], 'admin' => ['2.2.2.2']})
  end

  def setup
    Rack::IpAuthorizer.env_to_check = ['development']
  end

  def check_ip_for_path(path, ip, expected_result = 200, env = 'development')
    Rails.stub :env, env do
      get path, {}, {'REMOTE_ADDR' => ip}
      assert last_response.status == expected_result
    end
  end

  def test_env_checked
    check_ip_for_path('/test', '1.1.1.1')
  end

  def test_env_ignored
    Rack::IpAuthorizer.env_to_check = ['staging']
    check_ip_for_path('/test', '1.1.1.1', 200, 'staging')
  end

  def test_ip_allowed
    check_ip_for_path('/test', '1.1.1.1')
    check_ip_for_path('/test', '1.1.1.2')
    check_ip_for_path('/admin', '2.2.2.2')
  end

  def test_ip_refused
    check_ip_for_path('/test', '2.2.2.2', 403)
    check_ip_for_path('/admin', '1.1.1.1', 403)
    check_ip_for_path('/admin', '1.1.1.2', 403)
  end
end