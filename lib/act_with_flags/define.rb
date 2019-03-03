# rubocop:disable all
# frozen_string_literal: true

class ActWithFlags::Admin

  def add_accessors(origin, accessor, mask)
    model.class_eval %(
      def #{accessor}
        #{accessor}?
      end

      def #{accessor}?
        !( self.#{origin} & #{mask} ).zero?
      end

      def #{accessor}=(value)
        self.#{origin} ||= 0
        if self.class.act_with_flags.to_boolean(value)
          self.#{origin} |= #{mask}
          true
        else
          self.#{origin} &= ~#{mask}
          false
        end
      end
    )
  end

  def remove_accessor(accessor)
    my_undef model, accessor, "#{accessor}?", "#{accessor}="
  end

  def validate_accessor(*names)
    names.each { |acc|
      raise "redefining #{acc} rejected"  if model.method_defined?(acc)
    }
  end

  def my_undef(*names)
    names.each { |name|
      model.class_eval %(
        begin
          undef #{name}
        rescue
        end
      )
    }
  end

  def before_save
    model.class_eval %(
      before_save do |row|
        row.#{origin} &= ~row.class.act_with_flags.delete_mask
      end
    )
  end

end
