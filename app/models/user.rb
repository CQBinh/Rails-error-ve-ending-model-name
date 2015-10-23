class User < ActiveRecord::Base
  has_many :caves
  has_many :thank_gives
end
