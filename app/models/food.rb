class Food < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_foods, foreign_key: 'food_id'
end
