# JSWebBuilder [![Build Status](https://travis-ci.org/quams/js_web_builder.svg?branch=master)](https://travis-ci.org/quams/js_web_builder)

This gem is a simple little hack to introduce some teeny-weeny bit of JavaScript asset pipeline management to my [sinatra](http://www.sinatrarb.com/) web applications. And since I like [rake](http://rake.rubyforge.org/) the whole thing is basically a custom rake task.

This gem exists to allow for a more modular javascript development approach. It therefore does exactly and only the following things and in that order:

1. It reads all files in a given directory
2. For each file it searches for a special _//= require_ statement
3. It concatenates all in this manner required files into one and writes it to an output file

For a more detailed description look under the usage section.

The whole reason I did this gem is, because I spectacularly failed trying to integrate [sprockets](https://github.com/rails/sprockets) into my application. And having the functionality in my application **and** testing it got me nervous ticks.

So I did this. Even though there are most likely 42 other gems or methods to do exactly this. If you nevertheless like my little piece of code, feel free to use it. If you find a bug or want to add something, report it or create a pull request. If you think I am a moron for doing this, be polite and keep it to yourself.

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

### Overview

JSWebBuilder as basically nothing more than a simple implementation of [Rake::TaskLib](http://rake.rubyforge.org/Rake/TaskLib.html) in the style of [Rake::TestTask](http://rake.rubyforge.org/Rake/TestTask.html).

It consecutively reads all the files matching a pattern (default: "\*.js") within the root-level of an array of input directories. It scans each of the input files for the following pattern:

    //= require relative_path/filename

You might notice: That is not surprisingly the same syntax sprocket uses. So if you ever need or want to go down that road, you do not need to change things.

### Invocation

TBD

### Example

TBC

    assets/js    
    ├── lib
    │   ├── fu.js
    │   ├── module1.js
    │   ├── module2.js
    │   └── module3.js
    ├── main.js
    └── minime.js

```javascript
//= require lib/module1.js
//= require lib/module3.js

// The Big Document Ready Guard with the main implementation
$( document ).ready(function() {

  // do stuff here

}); // document ready

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org) (well, the last part is only in here, so that I won't forget it whenever it becomes interesting).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/quams/js_web_builder.

