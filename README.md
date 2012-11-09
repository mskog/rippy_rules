# RippyRules

A Ruby wrapper for the What.cd JSON API

## Installation

Add this line to your application's Gemfile:

    gem 'rippy_rules'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rippy_rules

## Usage

Initialize a client like so:

```ruby
client = RippyRules::Client.new(your_whatcd_username, your_whatcd_password)
```
You can then run any command in the API by calling it's corresponding method. Each method will return a hash

## API Documentation
The documentation for the API methods can be found in the What.cd wiki

## Examples

Searching for an artist
```ruby
client = RippyRules::Client.new(your_whatcd_username, your_whatcd_password)
results = client.browse({searchstr: 'Bruce Springsteen'})
```

## Contributing

To contribute to RippyRules, you must have a What.cd account. I do not have one and I do not know how to acquire one.
If you don't have an account, the specs will not run

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
