class Order < ApplicationRecord
  before_save do |row|
    row.flags ||= 0
    row.origin1 ||= 0
    row.origin2 ||= 0
    row.bigflags ||= ""
    row.errors.add :base, "panic" if row.name == "error"
  end
end
