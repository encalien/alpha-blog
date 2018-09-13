class User < ActiveRecord::Base
  has_many :articles
  
  before_save { self.email = email.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 8 }, 
                    format: { with: VALID_EMAIL_REGEX, message: "must be a valid email" }, confirmation: true
end
