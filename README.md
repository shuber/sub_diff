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

This gem introduces a couple new methods to [`String`](http://ruby-doc.org/core-2.2.0/String.html) objects.

* [`String#sub_diff`](http://ruby-doc.org/core-2.2.0/String.html#method-i-sub)
* [`String#gsub_diff`](http://ruby-doc.org/core-2.2.0/String.html#method-i-gsub)

These methods accept the same arguments as their `sub` and `gsub` counterparts.

```ruby
replaced = 'this is a test'.gsub_diff(/(\S*is)/, 'replaced(\1)') #=> #<SubDiff::Collection:0x007fc532049508>
```

The difference is that it returns a `SubDiff::Collection` instead. This object behaves like a `String`.

```ruby
puts replaced #=> "replaced(this) replaced(is) a test"
```

But it also allows us to check if the replacement actually *changed* anything.

```ruby
replaced.changed? #=> true
```

For a closer look at the changes, we can iterate thru each `Diff` in the replacment.

```ruby
replaced.each do |diff|
  puts diff.inspect
end

#=> "replaced(this)"
#=> " "
#=> "replaced(is)"
#=> " a test"
```

Each `Diff` object behaves just like a string, but also includes a few additional methods.

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

* `String#sub_diff`
* `String#gsub_diff`
* `SubDiff::Diff#changed?`
* `SubDiff::Diff#value`
* `SubDiff::Diff#value_was`
* `SubDiff::Collection#changed?`
* `SubDiff::Collection#clear`
* `SubDiff::Collection#diffs`
* `SubDiff::Collection#each`
* `SubDiff::Collection#reset`
* `SubDiff::Collection#size`

## Testing

```
bundle exec rspec
```


## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with the version or history.
* Send me a pull request. Bonus points for topic branches.


## License

[MIT](https://github.com/shuber/sub_diff/blob/master/LICENSE)  - Copyright © 2011 Sean Huber
