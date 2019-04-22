# CStash

A simple ruby stash.  It is basically a nested struct with a few extra
features.

## Features

+ Immutable structure - the structure you define can't be mutated.  Only the
  value of nodes can.
+ Type checking - when you set a node, its type (class) is checked against the
  old node and an exception is raised if there is a mismatch
+ Fast - there is no underlying hash or struct, so if you don't need to mutate
  data often cstash is pretty fast

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cstash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cstash

## Usage
```ruby
stash = CStash::Stash.new(
  a: {
    b: {
      c: {
        d: 1
      }
    },
    bb: false
  }
)

stash.a.b.c.d #=> 1
stash.a.bb? #=> false
stash.a.b.c.d = 4 #=> 4
stash.a.b.c.d = false #=> TypeError
stash.a.b.c = 1 #=> NoMethodError
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cstash.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
