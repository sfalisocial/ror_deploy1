class User < ActiveRecord::Base
  belongs_to :state
  has_secure_password
  has_many :comments, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :events_joined, through: :guests, source: :event

  validates :first_name,:last_name,:password, presence: true, :on => :create
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
