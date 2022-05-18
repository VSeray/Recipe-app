class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(['user_id = :id', { id: current_user.id.to_s }])
  end

  def show
    # p current_user.recipes.first.recipe_foods
    @recipe = Recipe.find(params[:id])
    @recipe_foods = RecipeFood.where(['recipe_id = :id', { id: params[:id].to_s }])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:notice] = 'Recipe created successfully'
      redirect_to recipes_path
    else
      flash[:alert] = 'Error: Could not create a recipe'
      redirect_to new_recipe_path
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def to_boolean
    self == 'true'
  end

  def recipe_params
    p = params.require(:post).permit(:name, :cooking_time, :preparation_time, :description, :public)
    p[:user_id] = current_user.id
    p
  end
end
