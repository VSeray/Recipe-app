require 'rails_helper'

RSpec.describe 'Recipe app', type: :feature do
  describe ' Recipe index page' do
    before(:each) do
      @user1 = User.create!(name: 'User1', created_at: Time.now,
                            role: 'admin', email: 'user1@gmail.com', password: '123456')
      visit user_session_path
      fill_in 'email', with: 'user1@gmail.com'
      fill_in 'pwd', with: '123456'
      click_button 'Log in'
      @recipe1 = Recipe.create(name: 'Recipe1', cooking_time: 1.5, preparation_time: 1,
                               description: 'description', public: true,
                               created_at: Time.now, updated_at: Time.now, user_id: @user1.id)
      @recipe2 = Recipe.create(name: 'Recipe2', cooking_time: 2, preparation_time: 0.5,
                               description: 'description', public: false,
                               created_at: Time.now, updated_at: Time.now, user_id: @user1.id)
      visit recipes_path
    end

    it 'Should see the heading "Recipes' do
      heading = page.has_selector?('h1', count: 1)
      expect(heading).to be true
      expect(page).to have_content 'Recipes'
    end

    it 'Should see the recipe title' do
      expect(page).to have_content(@recipe1.name)
      expect(page).to have_content(@recipe2.name)
    end

    it 'Should see the recipe description' do
      expect(page).to have_content(@recipe1.description)
      expect(page).to have_content(@recipe2.description)
    end

    it 'Should  see a Add new recipe button' do
      expect(page).to have_content 'Add new recipe'
    end

    it 'The Add new recipe button should lead to create recipe form' do
      click_link 'Add new recipe'
      expect(page).to have_current_path new_recipe_path
    end

    it 'Should lead the recipe details' do
      click_link 'Recipe1'
      expect(page).to have_current_path recipe_path(@recipe1.id)
    end

    it 'Should see list of current_user recipes' do
      expect(@user1.recipes.length).to eq 2
    end

    it 'Should see remove button' do
      expect(page).to have_content('remove')
      button = page.has_selector?('button', text: 'remove', count: 2)
      expect(button).to be true
    end
  end
end
