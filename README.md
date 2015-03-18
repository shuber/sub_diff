# [![Sean Huber](https://cloud.githubusercontent.com/assets/2419/6550752/832d9a64-c5ea-11e4-9717-6f9aa6e023b5.png)](https://github.com/shuber) sub_diff

[![Build Status](https://secure.travis-ci.org/shuber/sub_diff.svg)](http://travis-ci.org/shuber/sub_diff) [![Code Climate](https://codeclimate.com/github/shuber/sub_diff/badges/gpa.svg)](https://codeclimate.com/github/shuber/sub_diff) [![Coverage](https://codeclimate.com/github/shuber/sub_diff/badges/coverage.svg)](https://codeclimate.com/github/shuber/sub_diff) [![Gem Version](https://badge.fury.io/rb/sub_diff.svg)](http://badge.fury.io/rb/sub_diff)

Inspect the changes of your [`String#sub`] and [`String#gsub`] replacements.

[`String#sub`]: http://ruby-doc.org//core-2.2.0/String.html#method-i-sub
[`String#gsub`]: http://ruby-doc.org//core-2.2.0/String.html#method-i-gsub

## Installation

```
gem install sub_diff
```


## Requirements

Ruby 1.8.7+


## Usage

This gem introduces two new methods to `String`, `sub_diff` and `gsub_diff`, which accept the same arguments as their `sub` and `gsub` counterparts.

```ruby
replaced = 'this is a test'.gsub_diff(/(\S*is)/, 'replaced(\1)') #=> #<DiffCollection:0x007fc532049508>
```

The `replaced` object behaves just like a `String`.

```ruby
puts replaced #=> "replaced(this) replaced(is) a test"
```

It also allows you to check if the replacement actually changed anything.

```ruby
replaced.changed? #=> true
```

For a closer look at the changes, simply enumerate thru the returned replacements. Each iteration yields a `Diff` object which also behaves like a `String` but includes a few additional methods: `value`, `value_was`, and `changed?`.
  
```ruby
replaced.each do |diff|
  puts "    value: #{diff.value.inspect}"
  puts "value_was: #{diff.value_was.inspect}"
  puts " changed?: #{diff.changed?}"
end

#=>     value: "replaced(this)"
#=> value_was: "this"
#=>  changed?: true

#=>     value: " "
#=> value_was: " "
#=>  changed?: false

#=>     value: "replaced(is)"
#=> value_was: "is"
#=>  changed?: true

#=>     value: " a test"
#=> value_was: " a test"
#=>  changed?: false
```


## API

[YARD Documentation](http://www.rubydoc.info/github/shuber/sub_diff)


## Testing

```
bundle exec rspec
```


## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


## License

[MIT](https://github.com/shuber/sub_diff/blob/master/LICENSE)  - Copyright © 2011 Sean Huber
