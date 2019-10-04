class Order < ApplicationRecord

  before_save do |row|
    row.flags ||= 0
    row.bigflags ||= ''
#    row.errors.add :base, 'panic'  if row.name == 'error'
  end

end
