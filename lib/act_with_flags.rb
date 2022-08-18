# frozen_string_literal: true

# Principles:
#  POLA
#  KISS
#  YAGNI
#  POLS
#  DEI
#  TDD considered harmful
#  TGCB

#MARS patch
#was
# class << ActiveRecord::Base
#   attr_reader :act_with_flags
#
#   def add_to_flags(*flags, origin: :flags, **hash)
#     unless @act_with_flags
#       @act_with_flags ||= ActWithFlags::Admin.new self
#       @act_with_flags.add_mask_et_all origin
#     end
#
#     flags.each { |name| @act_with_flags.add_flag(name, origin, nil) }
#     hash.each { |name, pos| @act_with_flags.add_flag(name, origin, pos) }
#
#     @act_with_flags
#   end
#
#   def remove_from_flags(*flags)
#     flags.each { |name| @act_with_flags.remove_accessor(name) }
#   end
#
#   def clear_flags_at_save(*flags)
#     @act_with_flags.clear_at_save(*flags)
#   end
#  end
#now
module ActWithFlags
  module Base
    attr_reader :act_with_flags

    def add_to_flags(*flags, origin: :flags, **hash)
      unless @act_with_flags
        @act_with_flags ||= ActWithFlags::Admin.new self
        @act_with_flags.add_mask_et_all origin
      end

      flags.each { |name| @act_with_flags.add_flag(name, origin, nil) }
      hash.each { |name, pos| @act_with_flags.add_flag(name, origin, pos) }

      @act_with_flags
    end

    def remove_from_flags(*flags)
      flags.each { |name| @act_with_flags.remove_accessor(name) }
    end

    def clear_flags_at_save(*flags)
      @act_with_flags.clear_at_save(*flags)
    end
  end
end
#END patch

#MARS patch
#inserted:
class ActiveRecord::Base
  extend ActWithFlags::Base
end
#END patch

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require "act_with_flags/version"
require "act_with_flags/utils"
require "act_with_flags/define"
require "act_with_flags/admin"
require "act_with_flags/flags"
require "act_with_flags/clear"
require "act_with_flags/print"
