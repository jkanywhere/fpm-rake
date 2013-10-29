# FPM::Rake

[FPM](https://github.com/jordansissel/fpm) is a great tool to build and convert
between a variety of package formats.

[Rake](http://rake.rubyforge.org/) is a great tool to automate Ruby build and
release tasks.

`FPM::Rake` provides a Rake task for converting a gem into an RPM package using
fpm.

Currently only RPM is supported. Please consider implementing and submitting
tasks for other package formats supported by fpm.

The RPM configuration is currently very specify to my `ruby1.9` setup, I
would appreciate input on how to expose fpm's many configuration options to
users of the Rake task.

## Installation

Add this line to your application's Gemfile:

    gem 'fpm-rake'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fpm-rake

## Usage

In your `Rakefile` add

    require "fpm/rake_tasks"

Then run

    rake rpm:build

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
