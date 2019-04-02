# rubocop:disable all
# frozen_string_literal: true

# Principles:
#  POLA
#  KISS
#  YAGNI
#  POLS
#  DEI
#  TDD considered harmful

class << ActiveRecord::Base

if 1 == 1
p 111
  attr_accessor :act_with_flags
else
p 222
  attr_writer :act_with_flags

  def act_with_flags
    @act_with_flags ||= ActWithFlags::Admin.new self
  end
end

  def add_to_flags(*flags, origin: :flags, **hash)
#p "act_with_flags: add_to_flags #{flags.inspect}"
#p "act_with_flags: origin #{origin.inspect}"
#p "act_with_flags: hash   #{hash.inspect}"

    @act_with_flags ||= ActWithFlags::Admin.new self
    if origin.is_a?(Integer)
      hash[:origin] = origin
    else
      @act_with_flags.origin = origin
      @act_with_flags.delete_mask_et_all
      @act_with_flags.add_mask_et_all origin
    end

    flags.each { |name|      @act_with_flags.add_accessor(name, nil) }
    hash.each  { |name, pos| @act_with_flags.add_accessor(name, pos) }

    @act_with_flags
  end

  def remove_from_flags(*flags)
#p "remove_from_flags #{flags.inspect}"
    flags.each { |name| @act_with_flags.remove_accessor(name) }
  end

  def clear_flags_at_save(*flags)
#p "clear_flags_at_save #{flags.inspect}"
    flags.each { |name| @act_with_flags.add_to_delete_mask(name) }
    @act_with_flags.before_save
  end

end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
require 'act_with_flags/version'
require 'act_with_flags/utils'
require 'act_with_flags/define'
require 'act_with_flags/admin'
require 'act_with_flags/print'
