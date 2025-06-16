# ActWithFlags

[![Gem Version](https://img.shields.io/gem/v/act_with_flags?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/act_with_flags)
[![Downloads](https://img.shields.io/gem/dt/act_with_flags?color=168AFE&logo=rubygems&logoColor=FE1616)](https://rubygems.org/gems/act_with_flags)
[![GitHub Build](https://img.shields.io/github/actions/workflow/status/matique/act_with_flags/rake.yml?logo=github)](https://github.com/matique/act_with_flags/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-168AFE.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-168AFE.svg)](http://choosealicense.com/licenses/mit/)

[![Gem Version](https://badge.fury.io/rb/act_with_flags.svg)](http://badge.fury.io/rb/act_with_flags)
[![GEM Downloads](https://img.shields.io/gem/dt/act_with_flags?color=168AFE&logo=ruby&logoColor=FE1616)](https://rubygems.org/gems/act_with_flags)
[![rake](https://github.com/matique/act_with_flags/actions/workflows/rake.yml/badge.svg)](https://github.com/matique/act_with_flags/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](http://choosealicense.com/licenses/mit/)

A Rails gem required by key.matiq.

Handles booleans in "flags".
Defines setters and getters to access the booleans.

## Installation

As usual:
```ruby
# Gemfile
gem "act_with_flags"
```
and run "bundle install".

## Version 3.1.1

Option "range" can be specified just once for all
"add_to_flags" for a specific "origin".

For example:
~~~ruby
Order.add_to_flags range: ..0
...
Order.add_to_flags :a
~~~

Same as:
~~~ruby
Order.add_to_flags :a
...
Order.add_to_flags range: ..0
~~~

or:
~~~ruby
Order.add_to_flags :a, range: ..0
~~~

Examples for "range":
~~~ruby
Order.add_to_flags range: 0..17   # legal flag position from 0 to 17
Order.add_to_flags range: ..17    # legal flag position from 0 to 17
Order.add_to_flags range: nil..17 # legal flag position from 0 to 17
Order.add_to_flags range: 3..     # legal flag position from 3 to big_number
Order.add_to_flags range: 3..nil  # legal flag position from 3 to big_number
~~~

Invalid ranges:
~~~ruby
Order.add_to_flags range: -1..17   # range starting with a negative position
Order.add_to_flags range: :a..:z   # invalid range
Order.add_to_flags range: "a".."z" # invalid range
~~~


## Version 3.1.0

Added option "range" limiting the position of flags.

An example:
```ruby
ii = 3
Order.add_to_flags range: (2..4), a: (ii += 1) # accepted
Order.add_to_flags range: (2..4), b: (ii += 1) # raises exception
```

Option "range" enables an early static check.

Option "range" does not replace the dynamic "validate" in models,
which is strongly recommended for complex applications.
Due to Ruby "act_with_flags" can handle a huge quantity
of booleans in an integer (or a string),
but your database may fail above a certain amount of bits.

The option ":max_bits" is deprecated.


## Version 3.0.x

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
- [gem bitwise](https://github.com/kenn/bitwise)


## Miscellaneous

Copyright (c) 2019-2024 Dittmar Krall (www.matiq.com),
released under the [MIT license](https://opensource.org/licenses/MIT).
