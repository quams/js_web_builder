# JSWebBuilder

This gem is a simple little hack to introduce some teeny-weeny bit of JavaScript asset pipeline management to my [sinatra](http://www.sinatrarb.com/) web applications. 

This gem exists to allow for a more modular javascript development approach. It therefore does exactly and only the following things:

1. It reads all files in a given directory
2. For each file it searches for a special _//= require_ statement
3. It concatenates all in this manner required files into one and writes it to an output file

For a more detailed description look under the usage section.

The whole reason I did this gem is, because I spectacularly failed trying to integrate [sprockets](https://github.com/rails/sprockets) into my application. And having the functionality in my application **and** testing it got me nervous ticks.

So I did this. Even though there are most likely 42 other gems to do exactly this. If you nevertheless like my little piece of code, feel free to use it. If you find a bug or want to add something, report it or create a pull request.

## Installation

I currently don't plan to publish on [rubygems.org](https://rubygems.org), so you have to use the respective github extension.

Add this line to your application's Gemfile:

```ruby
gem 'js_web_builder', :git => "https://github.com/quams/js_web_builder.git"
```

And then execute:

    $ bundle

Or install it fresh from the source via:

    $ gem install specific_install
    $ gem specific_install https://github.com/quams/js_web_builder.git

Or clone it somewhere and then install it (see section Development).

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org) (well, the last part is only in here, so that I won't forget it whenever it becomes interesting).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/quams/js_web_builder.

