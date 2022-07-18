# frozen_string_literal: true

class ActWithFlags::Admin
  def to_s
    res = []
    res << title("Variables")
    res << variables(:boolean_hash)
    res << variables(:delete_mask)

    res << blk("Flags sorted alfabetically") { |key, loc|
      "#{key} #{loc}"
    }
    res << blk("Flags and mask; sorted alfabetically") { |key, loc|
      "#{key}  #{sprintf("0x%08X", mask(key))}"
    }
    res << blk("FLAG assignment; sorted alfabetically") { |key, loc|
      "FLAG_#{key.upcase} = #{sprintf("0x%08X", mask(key))}"
    }

    res << title("@locations")
    res << @locations
    res.flatten.join("\n")
  end

  private

  def title(msg)
    sep = "#" * 10
    ["", "#{sep} #{msg} #{sep}"]
  end

  def blk(legend, &block)
    res = [title(legend)]
    sorted = @locations.sort
    sorted.each { |key, loc| res << block.call(key, loc) }
    res
  end

  def variables(*names)
    names.collect { |name|
      value = instance_variable_get(:"@#{name}")
      "#{name} #{value}"
    }
  end
end
