# Rack::Ip::Authorizer

Basic Rack middleware for checking Rails3 request remote IP

## Installation

Add this line to your application's Gemfile:

    gem 'rack-ip-authorizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-ip-authorizer

## Usage

### Rails 3 apps

1. Create a file named "ip_authorizations.yml" in the config directory
2. Fill it with key as path and values as IPs:

```yaml
admin:
    - 192.168.0.1
    - 192.168.0.2
    - 192.168.0.3
superadmin:
    - 192.168.0.1
    - 192.168.0.2
```

Environment filter

Create an initializer and fill it with:

```ruby
Rack::IpAuthorizer.env_to_check = ['staging','development']
```

## Contributing

1. Fork it
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create new Pull Request
