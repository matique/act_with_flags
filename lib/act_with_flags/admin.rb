# rubocop:disable all
# frozen_string_literal: true

class ActWithFlags::Admin

  attr_reader :model
  attr_reader :origin
  attr_reader :delete_mask

  def initialize(model)
    @model = model
    @origin = :flags
    @map = {}
    @delete_mask = 0
    @max_position = 512 - 1
    @boolean_hash = {}
    [true,  'true',  1, '1'].each { |x| @boolean_hash[x] = true }
    [false, 'false', 0, '0'].each { |x| @boolean_hash[x] = false }
  end

  def reset_model(model)
    initialize model
  end

  def names
    @map.keys.sort
  end

  def to_boolean(value)
    res = @boolean_hash[value]
    return res  unless res.nil?

    raise "invalid boolean <#{value}>"
  end

  def origin=(name)
p [888, self]
p [80, @map]
p [81, @map.empty?]
p [82, origin == name]
p [82, origin, name]
p [83, @origin]
    raise 'invalid update of origin'  unless @map.empty? || (origin == name)
    @origin = name
  end

  def position(name)
    @map[name]
  end

  def mask(*names)
    names.inject(0) { |msk, name| msk | ( 1 << position(name) ) }
  end

  def all?(*names)
    names.inject(0) { |msk, name| msk | ( 1 << position(name) ) }
  end

  def add(name, pos)
    values = @map.values
    pos ||= (0..@max_position).detect { |i| !values.include?(i) }
    raise "invalid position '#{name} @ #{pos}'"  unless pos
    raise "name in use '#{name} @ #{pos}'"       if @map.key?(name)
    raise "position in use '#{name} @ #{pos}'"   if @map.value?(pos)
    @map[name] = pos
  end

  def add_to_delete_mask(name)
    @delete_mask |= mask(name)
  end

end
