# ActWithFlags
[![Gem Version](https://badge.fury.io/rb/act_with_flags.png)](http://badge.fury.io/rb/act_with_flags)

Required by key.matiq.

## Installation

Add this line to your application's Gemfile:

    gem 'act_with_flags'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install act_with_flags

## Version 3.x

As required by key.matiq an enhanced "origin:" has been implemented.
Act_with_flags now supports many "origin:"s.

An example:

~~~
Order.add_to_flags :a # origin is :flags
Order.add_to_flags :b, b2: 63 # origin is :flags
Order.add_to_flags :c, origin: :origin1
Order.add_to_flags d: 3, origin: :origin2
Order.add_to_flags :d2, origin: :origin2
~~~

The default "origin:" continues to be "flags".

## Links

Further reading:

- [gem bitmask_attributes](https://github.com/joelmoss/bitmask_attributes)
- [gem bitfields](https://github.com/grosser/bitfields)
- [gem active_flag](https://github.com/kenn/active_flag)
- [gem has-bit-field](https://github.com/pjb3/has-bit-field))
- [gem bitfield_attribute](https://github.com/gzigzigzeo/bitfield_attribute)

## License MIT

Copyright (c) 2019-2022 [Dittmar Krall](matiq.com UG) and
is released under the MIT license:

* https://opensource.org/licenses/MIT
