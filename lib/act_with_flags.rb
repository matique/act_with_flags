# frozen_string_literal: true

# Principles:
#  POLA
#  KISS
#  YAGNI
#  POLS
#  DEI
#  TDD considered harmful
#  TGCB

module ActWithFlags
  module Base
    attr_reader :act_with_flags

    def add_to_flags(*flags, origin: :flags, range: nil, **hash)
      init(origin, range)

      flags.each { |name| @act_with_flags.add_flag(name, nil, origin) }
      hash.each { |name, pos| @act_with_flags.add_flag(name, pos, origin) }

      @act_with_flags
    end

    def remove_from_flags(*flags)
      flags.each { |name| @act_with_flags.remove_accessor(name) }
    end

    def clear_flags_at_save(*flags)
      @act_with_flags.clear_at_save(*flags)
    end

    private

    def init(origin, range)
      unless @act_with_flags
        @act_with_flags ||= ActWithFlags::Admin.new self
        @act_with_flags.add_mask_et_all origin
      end

      rng = @act_with_flags.ranges[origin]
      unless range.nil? || (range == rng)
        msg = "incompatible ranges #{range} - #{rng}"
        raise ArgumentError, msg unless rng.nil?
        @act_with_flags.ranges[origin] = range if range
        validate_previous_positions(origin, range)
      end
    end

    def validate_previous_positions(origin, range)
      return if range.nil?

      @act_with_flags.locations.each do |name, location|
        next unless location.origin == origin

        @act_with_flags.validate_position(range, location.position)
      end
    end
  end
end

class ActiveRecord::Base
  extend ActWithFlags::Base
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require "act_with_flags/version"
require "act_with_flags/utils"
require "act_with_flags/define"
require "act_with_flags/admin"
require "act_with_flags/flags"
require "act_with_flags/clear"
require "act_with_flags/print"
