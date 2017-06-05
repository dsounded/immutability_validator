# ImmutabilityValidator

This gem brings immutability validation to your `Rails` project. Let's say you want to describe your model from business
perspective when you really don't want to allow to change the persisted state of some field during mutation methods like
(`save`, `update`, `update!` etc). This is kind of different from `readony: true` option which silently ignore the
updating process, the main goal of this gem is to let end user know about such a stuff with provided error message.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'immutability_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install immutability_validator

## Usage

Just add the next line in your model:

`validates :my_field, immutability: true`

Or use a shorthand:

`validates_immutability_of :my_field`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/immutability_validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

