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

No relation to [curzonj's Fpm::Rake](https://github.com/curzonj/fpm-rake/).

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

To package your gem itself in RPM format run

    rake rpm:build

To package each of your gem's dependencies into RPM format run

    rake rpm:dependencies

To remove all .rpm files from the pkg directory run

    rake rpm:clean

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Please send comments and feedback. Does this `FPM::Rake` fit into your workflow?

