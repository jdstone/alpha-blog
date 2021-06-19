class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  validates :firstname, presence: true, length: { minimum: 2, maximum: 45 }
  validates :lastname, presence: true, length: { minimum: 2, maximum: 45 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 105 }
  has_secure_password
  # attr_accessor :current_password
  # validate :check_if_current_password_is_correct, on: :update

  # def check_if_current_password_is_correct
  #   unless password.blank?
  #     user = User.find_by_id(id)
  #     if (user.authenticate(current_password) == false)
  #       # flash[:alert] = "Your current password is incorrect"
  #       errors.add(:current_password, "is incorrect.")
  #     end
  #   end
  # end
end