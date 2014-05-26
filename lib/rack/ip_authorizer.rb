require "rack/version"

module Rack
  class IpAuthorizer
    @env_to_check = ["production"]
    class << self
      attr_accessor :env_to_check
    end

    def initialize(app, ip_authorizations_by_path)
      @app, @ip_authorizations_by_path = app, ip_authorizations_by_path
    end

    def call(env)
      if Rack::IpAuthorizer.env_to_check.include? Rails.env
        req = Rack::Request.new(env)

        @ip_authorizations_by_path.each do |protected_url, authorized_ips|
          if req.path.start_with?("/#{protected_url}") && !authorized_ips.include?(req.env['REMOTE_ADDR'])
            return forbidden
          end
        end
      end

      @app.call(env)
    end

    private

    def forbidden
      [403,
       {'Content-Type' => 'text/plain',
        'Content-Length' => '0'},
       []
      ]
    end

  end
end
