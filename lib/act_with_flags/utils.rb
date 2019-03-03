# xrubocop:disable all
# xfrozen_string_literal: true

class ActWithFlags::Admin

  def add_accessor(name, pos)
#p "** act_with_flags: add_accessor '#{name} @ #{pos}'"
    accessor = name.to_sym
    validate_accessor accessor, "#{accessor}?", "#{accessor}="

    add accessor, pos
    mask = mask(accessor)
    origin = self.origin
    add_accessors(origin, accessor, mask)
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
    )
  end

  def delete_mask_et_all
    my_undef :flags_mask, :flags_any?, :flags_all?, :flags_none?
  end

  def reset
    delete_mask_et_all
    names.each { |name|
      remove_accessor name
    }
    self.reset_model model
  end

end
