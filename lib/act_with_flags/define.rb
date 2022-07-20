# frozen_string_literal: true

class ActWithFlags::Admin
  def add_accessors(accessor, origin, mask)
    unless model.method_defined?(:act_with_flags)
      model.class_eval %(
        def act_with_flags
          #{model}.act_with_flags
        end
      ), __FILE__, __LINE__ - 4
    end

    model.class_eval %(
      def #{accessor}
        #{accessor}?
      end

      def #{accessor}?
        raise "Uninitialized '#{model}.#{origin}'" if #{origin}.nil?
        if #{origin}.is_a?(String)
          flags = self.#{origin}.to_i
          !( flags & #{mask} ).zero?
        else
          !( self.#{origin} & #{mask} ).zero?
        end
      end

      def #{accessor}=(value)
        raise "Uninitialized '#{model}.#{origin}'" if #{origin}.nil?
        is_a_string = #{origin}.is_a?(String)
        # flags = is_a_string ? self.#{origin}.to_i : self.#{origin}
        flags = self.#{origin}.to_i
        flags ||= 0

        result = self.act_with_flags.to_boolean(value)
        if result
          flags |= #{mask}
        else
          flags &= ~#{mask}
        end
        self.#{origin} = is_a_string ? flags.to_s : flags

        result
      end
    ), __FILE__, __LINE__ - 31
  end

  def remove_accessor(accessor)
    my_undef model, accessor, "#{accessor}?", "#{accessor}="
  end

  private

  def validate_accessor(*names)
    names.each { |acc|
      raise "redefining #{acc} rejected" if model.method_defined?(acc)
    }
  end

  def my_undef(*names)
    names.each { |name|
      model.class_eval %(
        begin
          undef #{name}
        rescue
        end
      ), __FILE__, __LINE__ - 5
    }
  end
end
