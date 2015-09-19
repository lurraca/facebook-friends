class Authorization < ActiveRecord::Base
  belongs_to :user

  validates :provider, presence: true, inclusion: { in: %w(facebook), message: "%{value} is not a supported provider." }
  validates :uid, presence: true
  validates :user, presence: true
end
