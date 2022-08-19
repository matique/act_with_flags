# ActWithFlags

[![Gem Version](https://badge.fury.io/rb/act_with_flags.png)](http://badge.fury.io/rb/act_with_flags)

Required by key.matiq.

Handles booleans in "flags".
Defines setters and getters to access the booleans.


## Installation

As usual:
```ruby
# Gemfile
...
gem 'act_with_flags'
```

or manually:
```shell
$ gem install act_with_flags
```


## Version 3.x

As required by key.matiq an enhanced "origin:" has been implemented.
Act_with_flags now supports many "origin:"s
(not just renaming the default "flags").

An example:

```ruby
Order.add_to_flags :a # origin is :flags
Order.add_to_flags :b, b2: 63 # origin is :flags
Order.add_to_flags :c, origin: :origin1
Order.add_to_flags d: 3, origin: :origin2
Order.add_to_flags :d2, origin: :origin2
```

The default "origin:" continues to be "flags".

The option ":max_bits" is deprecated.


## Testing

As "Best Practice" a test coverage of 100% has been achieved
(and should be kept).

GitHub workflow enable tests for several configurations.
Please, feel free to inspect the corresponding file.

The "gem appraisal" is used for an additional set of configurations.
Feel free to inspect the corresponding file.


## Links

Further reading:

- [gem bitmask_attributes](https://github.com/joelmoss/bitmask_attributes)
- [gem bitfields](https://github.com/grosser/bitfields)
- [gem active_flag](https://github.com/kenn/active_flag)
- [gem has-bit-field](https://github.com/pjb3/has-bit-field)
- [gem bitfield_attribute](https://github.com/gzigzigzeo/bitfield_attribute)


## License MIT

Copyright (c) 2019-2022 [Dittmar Krall](matiq UG (haftungsbeschränkt))
and is released under the MIT license:

* https://opensource.org/licenses/MIT
