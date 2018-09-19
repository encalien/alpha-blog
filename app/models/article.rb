class Article < ActiveRecord::Base
  belongs_to :user
  has_many :articles_categories
  has_many :categories, through: :articles_categories
  
  validates :title, presence: true, length: { minimum: 3, maximum: 60 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :user_id, presence: true
end
