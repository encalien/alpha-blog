class Category < ActiveRecord::Base
  has_many :articles_categories
  has_many :articles, through: :articles_categories
  
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
end