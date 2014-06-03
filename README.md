# Rack::Ip::Authorizer

Basic Rack middleware for Rails 3 to authorize access to path by IP

## Installation

Add this line to your application's Gemfile:

    gem 'rack-ip-authorizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-ip-authorizer

## Usage

### Rails 3 apps

1. Create an initializer defining the environment you want to watch (production by default), example:
```ruby
Rack::IpAuthorizer.env_to_check = ['staging','development']
```
2. Create a file named "ip_authorizations.yml" in config directory
3. Fill it with paths (keys) and IPs (values) see example below

```yaml
admin:
    - 192.168.0.1
    - 192.168.0.2
    - 192.168.0.3
monitor:
    - 192.168.0.1
    - 192.168.0.2
```
4. According to this example, path to http://www.my-application.com/admin and http://www.my-application.com/monitor have access restricted by IP  

## Contributing

1. Fork it
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create new Pull Request