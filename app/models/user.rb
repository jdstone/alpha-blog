class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  validates :firstname, presence: true, length: { minimum: 2, maximum: 45 }
  validates :lastname, presence: true, length: { minimum: 2, maximum: 45 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 105 }
  has_secure_password

  attr_accessor :current_password, :new_password

  validate :current_password_is_correct?, if: :validate_password?, on: :update

  def current_password_is_correct?
    # For some stupid reason authenticate always returns false when called on self
    if User.find(id).authenticate(current_password) == false
      errors.add(:current_password, "is incorrect.")
    end
  end

  def validate_password?
    # if (!new_password.blank? && !password_confirmation.blank?)
    if !password.blank?
      true
    else
      false
    end
  end
end
