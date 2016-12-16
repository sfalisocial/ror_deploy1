class Event < ActiveRecord::Base
  belongs_to :state
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :users_joined, through: :guests, source: :user
end
