class ShoppingListController < ApplicationController
  def index
    @recipes = current_user.recipes
    @foods = Food.all
    @total_price = 0
    @recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        @total_price += (recipe_food.quantity * recipe_food.food.price)
      end
    end
  end
end
