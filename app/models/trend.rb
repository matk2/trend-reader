class Trend < ActiveRecord::Base
  belongs_to :rate
  has_one :deal
end
