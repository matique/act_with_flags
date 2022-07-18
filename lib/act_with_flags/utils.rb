# frozen_string_literal: true

class ActWithFlags::Admin
  def add_flag(name, origin, pos)
    accessor = name.to_sym
    validate_accessor accessor, "#{accessor}?", "#{accessor}="

    add_to_locations accessor, [origin, pos]
    mask = mask(accessor)
    add_accessors(accessor, origin, mask)
  end

  def add_mask_et_all(origin)
    model.class_eval %(
      def flags_mask(*names)
        self.class.act_with_flags.mask(*names)
      end

      def flags_any?(*names)
        mask = self.class.act_with_flags.mask(*names)
        !( self.#{origin} & mask ).zero?
      end

      def flags_all?(*names)
        mask = self.class.act_with_flags.mask(*names)
        ( self.#{origin} & mask ) == mask
      end

      def flags_none?(*names)
        mask = self.class.act_with_flags.mask(*names)
        ( self.#{origin} & mask ).zero?
      end
    ), __FILE__, __LINE__ - 19
  end

  def reset
    names.each { |name|
      remove_accessor name
    }
    reset_model model
  end
end
