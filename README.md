# JSWebBuilder [![Build Status](https://travis-ci.org/quams/js_web_builder.svg?branch=master)](https://travis-ci.org/quams/js_web_builder)

This gem is a simple little hack to introduce some teeny-weeny bit of JavaScript asset pipeline management to my [sinatra](http://www.sinatrarb.com/) web applications. And since I like [rake](http://rake.rubyforge.org/) the whole thing is basically a custom rake task.

This gem exists to allow for a more modular javascript development approach. It therefore does exactly and only the following things and in that order:

1. It reads all files in a given directory
2. For each file it searches for a special _//= require_ statement
3. It concatenates all in this manner required files into one and writes it to an output file

For a more detailed description look under the usage section.

The whole reason I did this gem is, because I spectacularly failed trying to integrate [sprockets](https://github.com/rails/sprockets) into my application. And having the functionality _within_ my application **and** testing it there, while using it gave me nervous ticks.

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

You might notice: That is not surprisingly the same syntax sprocket uses. So if you ever need or want to go down that road, you do not need to change too many things.

The interpretation of the requires is pretty simple and adheres strictly to the following rules:

1. **Relative path:** All includes are relative to the file read. In my cases required files are either in the same directory, or more likely, in a subdirectory.
2. **Order:** JSWebBuilder follows the order of the require statements when concatenating. The end of the concatenated file will be the input file.
3. **No recursion:** The required files are not interpreted at all. In principle that would be simple, bu I currently really have no desire to implement a endless-loop detection.

That's basically it, there is really not any magic at all involved!

### Invocation

TBD

### Example

Imagine the following tree for the javascript files of our web application:

    assets/js    
    ├── lib
    │   ├── fu.js
    │   ├── module1.js
    │   ├── module2.js
    │   └── module3.js
    ├── main.js
    └── minime.js

And *minime.js* looking like this:

```javascript
//= require lib/module1.js
//= require lib/module3.js

// The Big Document Ready Guard with the main implementation
$( document ).ready(function() {
  // do stuff here
}); // document ready
```

Include this code in the respective Rake file:

```ruby
JSWebBuilder::BuildTask.new(:build_js) do |b|
    b.outdir    << File.join(File.dirname(__FILE__),"public/js/")
    b.inputdirs << File.join(File.dirname(__FILE__),"assets/js/")
end
```

And the resulting _minime.js_ in the _public/js_ folder is the equivalent of the following shell command:

    $ cat assets/js/lib/module1.js assets/js/lib/module3.js assets/js/minime.js > public/js/minime.js

## ToDos:

I might want to add the following in the near future:

- Make it a "real" gem, e.g. pushing it to [rubygems.org](https://rubygems.org)
- Include post-processors, eg. [uglifier](https://github.com/lautis/uglifier) or [Closure Compiler](https://github.com/documentcloud/closure-compiler)
- Make an exclude pattern
- lib path
- Make a manifest-based clean target

Or I just give sprockets another try...

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org) (well, the last part is only in here, so that I won't forget it whenever it becomes interesting).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/quams/js_web_builder.

