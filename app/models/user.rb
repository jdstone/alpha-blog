class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles
  validates :firstname, presence: true, length: { minimum: 2, maximum: 45 }
  validates :lastname, presence: true, length: { minimum: 2, maximum: 45 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 105 }
end