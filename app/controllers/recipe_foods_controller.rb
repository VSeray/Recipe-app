class RecipeFoodsController < ApplicationController
	def new
		@foods = Food.all
		@recipe_food = RecipeFood.new
	end

	def create
    
		@recipe_food = RecipeFood.new(recipe_food_params)

		if @recipe_food.save
      flash[:notice] = 'Food added successfully'
      redirect_to recipe_path(setup_recipe_id)
    else
      #flash[:alert] = 'Error: Could not Add fod to recipe'
      flash[:alert] = alert.full_messages
      redirect_to new_recipe_recipe_food_path(setup_recipe_id)
    end
	end

	private

	def setup_recipe_id
		params[:recipe_id]
	end

	def recipe_food_params
		p = params.require(:recipe_food).permit(:food_id, :quantity)
		p[:recipe_id] = setup_recipe_id
		p
	end

end
