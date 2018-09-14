class User < ActiveRecord::Base
  has_many :articles
  has_secure_password
  
  before_save { self.email = email.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
                    format: { with: VALID_EMAIL_REGEX, message: "must be a valid email" }, confirmation: true
  validates :password, length: { in: 8..20 }, confirmation: true
  validates :email_confirmation, presence: true
  validates :password_confirmation, presence: true
end
