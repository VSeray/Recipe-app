class RecipeFood < ApplicationRecord
  belongs_to :food, class_name: 'Food'
  belongs_to :recipe, class_name: 'Recipe'

  validates :quantity, presence: true, numericality: { greater_than: 0, less_than: 1_000_000 }
end
