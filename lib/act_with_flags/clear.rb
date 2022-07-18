# frozen_string_literal: true

class ActWithFlags::Admin
  attr_reader :clears

  def clear_at_save(*flags)
    flags.each { |name| add_to_clear_mask(name) }
    clears.each { |orig, mask|
      before_save(orig.to_s, mask)
    }
    @clears = {}
  end

  private

  def add_to_clear_mask(name)
    orig, _pos = location(name)
    mask = @clears[orig] || 0
    mask |= 1 << position(name)
    @clears[orig] = mask
  end

  def before_save(orig, mask)
    model.class_eval %(
      before_save do |row|
        row.#{orig} &= ~#{mask}
      end
    ), __FILE__, __LINE__ - 4
  end
end
