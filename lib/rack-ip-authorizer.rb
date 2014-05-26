require File.join(File.expand_path(File.dirname(__FILE__)), 'rack/ip_authorizer')
require 'yaml'

if defined? Rails
  case Rails::VERSION::MAJOR
    when 3
      class Rack::IpAuthorizer::Railtie < Rails::Railtie
        initializer('rack-ip-authorizer.append') { |app|
          path = File.join(File.expand_path('config'), '/ip_authorizations.yml')
          if File.exists?(path)
            ip_authorizations_by_path = YAML.load_file(path)
          else
            raise "config/ip_authorizations.yml is missing"
          end
          app.config.middleware.insert_after(ActionDispatch::RemoteIp, Rack::IpAuthorizer, ip_authorizations_by_path)
        }
      end
  end
end