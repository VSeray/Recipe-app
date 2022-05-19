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
      @recipe1 = Recipe.create(name: 'Recipe1', cooking_time: 1.5, preparation_time: 1, description: 'description',
                               public: true, created_at: Time.now, updated_at: Time.now, user_id: @user1.id)
      @food = Food.create(name: 'orange', price: 15, measurement_unit: 'kg', user_id: @user1.id, created_at: Time.now)
      @recipe_food = RecipeFood.create(food_id: @food.id, recipe_id: @recipe1.id, quantity: 25, created_at: Time.now)
      visit general_shopping_list_path
    end

    it 'Should see the heading ' do
      heading = page.has_selector?('h1', count: 1)
      expect(heading).to be true
      expect(page).to have_content 'Shopping List'
    end

    it 'Should see recipe foods table' do
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Price')
    end

		it 'Should see the food name' do
      expect(page).to have_content(@food.name)
    end

		it 'Should see the Amount of food items to buy' do
      expect(page).to have_content('Amount of food items to buy: 1')
    end

		it 'Should see the Total of food needed' do
      expect(page).to have_content('Total of food needed: $375.0')
    end

		it 'Should see the price column' do
			price = @food.price * @recipe_food.quantity
      expect(page).to have_content("$#{price}")
    end

		it 'Should see the quantity column' do
      expect(page).to have_content("#{@recipe_food.quantity} kg")
    end
  end
end
