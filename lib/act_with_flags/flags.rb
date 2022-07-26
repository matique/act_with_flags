# frozen_string_literal: true

class ActWithFlags::Admin
  Location = Struct.new(:model, :origin, :position)

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
      model, orig, pos = location(flag).values
      idx = "#{model}##{orig}"
      mask = res[idx] || 0
      res[idx] = mask | (1 << pos)
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
    location(name).position
  end

  def add_to_locations(flag, location)
    location = check_position(location)
    who = "<#{flag}: #{location.origin}@#{location.position}>"
    raise "name already used #{who}" if @locations.key?(flag)
    bool = @locations.has_value?(location)
    raise "position already used #{who}" if bool
    @locations[flag] = location
  end

  def check_position(location)
    model, orig, pos = location.values
    return location if pos

    max_position = -1
    @locations.each { |name, location|
      model2, orig2, pos2 = location.values
      next unless model == model2 && orig == orig2

      max_position = pos2 if pos2 > max_position
    }

    Location.new(model, orig, max_position + 1)
  end
end
