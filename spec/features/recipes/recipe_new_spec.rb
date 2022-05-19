require 'rails_helper'

RSpec.describe 'Recipe app', type: :feature do
  describe ' Recipe new page' do
    before(:each) do
      @user1 = User.create!(name: 'User1', created_at: Time.now,
                            role: 'admin', email: 'user1@gmail.com', password: '123456')
      visit user_session_path
      fill_in 'email', with: 'user1@gmail.com'
      fill_in 'pwd', with: '123456'
      click_button 'Log in'
      @recipe1 = Recipe.create!(id: 1, name: 'Recipe1', cooking_time: 1.5, preparation_time: 1, description: 'description',
                                public: true, created_at: Time.now, updated_at: Time.now, user_id: @user1.id)
      @food = Food.create(id: 1, name: 'orange', price: 15, measurement_unit: 'kg', user_id: @user1.id,
                          created_at: Time.now)
      @recipe_food = RecipeFood.create(food_id: @food.id, recipe_id: @recipe1.id, quantity: 25, created_at: Time.now)
      visit new_recipe_recipe_food_path(@recipe1)
    end

    it 'Should see the heading ' do
      heading = page.has_selector?('h1', count: 1)
      expect(heading).to be true
      expect(page).to have_content 'recipe food'
    end

    it 'Should see recipe foods table' do
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Unit Price')
      expect(page).to have_content('Action')
      expect(page).to have_content('Measurement Unit')
    end

    it 'Should see list of recipe food' do
      expect(page).to have_content('orange')
      expect(page).to have_content(@food.measurement_unit)
      expect(page).to have_content(@food.price)
    end
  end
end
