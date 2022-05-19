require 'rails_helper'

RSpec.describe 'Recipe app', type: :feature do
  describe ' Recipe show page' do
    before(:each) do
      @user1 = User.create!(name: 'User1', created_at: Time.now,
                            role: 'admin', email: 'user1@gmail.com', password: '123456')
      visit user_session_path
      fill_in 'email', with: 'user1@gmail.com'
      fill_in 'pwd', with: '123456'
      click_button 'Log in'
      @recipe1 = Recipe.create(name: 'Recipe1', cooking_time: 1.5, preparation_time: 1,
                               description: 'description',
                               public: true, created_at: Time.now,
                               updated_at: Time.now, user_id: @user1.id)
      @food = Food.create(name: 'orange', price: 15, measurement_unit: 'kg', user_id: @user1, created_at: Time.now)
      @recipe_food = RecipeFood.create(food_id: @food.id, recipe_id: @recipe1.id, quantity: 25, created_at: Time.now)
      visit recipe_path(@recipe1)
    end

    it 'Should see the heading "Recipe1' do
      heading = page.has_selector?('h1', count: 1)
      expect(heading).to be true
      expect(page).to have_content 'Recipe1'
    end

    it 'Should see the recipe title' do
      expect(page).to have_content(@recipe1.name)
    end

    it 'Should see the recipe description' do
      expect(page).to have_content(@recipe1.description)
    end

    it 'Should  see a Add ingredient button' do
      expect(page).to have_content 'Add ingredient'
    end

    it 'The Add ingredient button should lead to create food form' do
      click_link 'Add ingredient'
      expect(page).to have_current_path(new_food_path)
    end

    it 'Should lead the new recipe food ' do
      click_link 'Add food to the recipe'
      expect(page).to have_current_path new_recipe_recipe_food_path(@recipe1.id)
    end

    it 'Should see recipe foods table' do
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Value')
      expect(page).to have_content('Actions')
    end
  end
end
