class RecipesController < ApplicationController

	def index
		current_user = 1
		@recipes = Recipe.where(['user_id = :id', { id: current_user.to_s }])
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		
	end
	
end
