class Deal < ActiveRecord::Base
  belongs_to :user
  belongs_to :trend

  validates :trend_id, presence: true
  validates :fundamental, presence: true
  validates :user_id, presence: true
end
