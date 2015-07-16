class Rate < ActiveRecord::Base
  has_one :trend
  belongs_to :currency_pair
end
