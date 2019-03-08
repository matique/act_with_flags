# rubocop:disable all
# frozen_string_literal: true

class ActWithFlags::Admin

  def to_s
    res = []
    res << title('Variables')
    res << variables(:origin, :boolean_hash)
    res << variables(:delete_mask)

    res << title('Flags sorted alfabetically')
    @map.sort.each { |key, pos| res << "#{key}  #{position(key)}" }

    res << title('Flags sorted by position')
    @map.sort.sort_by(&:last).each { |key, pos|
      res << "#{key}  #{position(key)}"
    }

    res << title('Flags and mask; sorted alfabetically')
    @map.sort.each { |key, pos|
      res << "#{key}  #{sprintf('0x%08X', mask(key))}"
    }

    res << title('FLAG assignment; sorted alfabetically')
    @map.sort.each { |key, pos|
      res << "FLAG_#{key.upcase} = #{sprintf('0x%08X', mask(key))}"
    }

    res << title('FLAG assignment; sorted by position')
    @map.sort.sort_by(&:last).each { |key, pos|
      res << "FLAG_#{key.upcase} = #{sprintf('0x%08X', mask(key))}"
    }

    res.flatten.join("\n")
  end

 private
  def title(msg)
    sep = '#' * 10
    ['', "#{sep} #{msg} #{sep}"]
  end

  def variables(*names)
    names.collect { |name|
      value = instance_variable_get(:"@#{name}")
      "#{name} #{value}"
    }
  end

end
