class User < ActiveRecord::Base
  is_record_history_author

  validates :login, :password, :name, :presence => true
  validates :login, :uniqueness => true
end

class SomeData < ActiveRecord::Base
  has_record_history :only => [:name, :value]

  validates :name, :presence => true, :uniqueness => true
  validates :value, :presence => true
end