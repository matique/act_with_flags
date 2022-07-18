# frozen_string_literal: true

class ActWithFlags::Admin
  attr_reader :locations

  def mask(*flags)
    return 0 if flags.empty?

    res = mask2d(*flags)
    raise "Mixing origins fails: #{flags}" unless res.length == 1

    res.values.first
  end

  def mask2d(*flags)
    res = {}
    flags.each { |flag|
      orig, pos = location(flag)
      mask = res[orig] || 0
      res[orig] = mask | (1 << pos)
    }
    res
  end

  def location(name)
    location = @locations[name]
    return location if location

    parent = model.superclass.act_with_flags
    return parent.location(name) if parent

    raise "unknown flag '#{model}##{name}'"
  end

  private

  def position(name)
    location(name).last
  end

  def names
    @locations.keys.sort
  end

  def add_to_locations(name, location)
    location = check_position(location)
    who = "<#{name}: #{location.last} @ #{location.first}>"
    raise "name already used #{who}" if @locations.key?(name)
    bool = @locations.has_value?(location)
    raise "position already used #{who}" if bool
    @locations[name] = location
  end

  def check_position(location)
    orig, pos = location
    return location if pos

    max_position = -1
    @locations.each { |name, location|
      orig2, pos2 = location
      next unless orig == orig2

      max_position = pos2 if pos2 > max_position
    }

    [location.first, max_position + 1]
  end
end
