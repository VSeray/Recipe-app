class RecipeFoodsController < ApplicationController
	def new
		@foods = Food.all
		@recipe_food = RecipeFood.new
	end

end
