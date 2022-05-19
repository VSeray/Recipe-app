require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create(name: 'Cork', email: 'example@mail.com', password: 'password') }
  let(:recipe) {Recipe.create(name: 'Recipe1', cooking_time: 1.5, preparation_time: 1, 
                   description: 'description',
                  public: true, created_at: Time.now, updated_at: Time.now, user_id: user.id)}

  describe 'Test Get recipes#index' do
    before(:each) do
      sign_in user
      get '/recipes/'
    end
    it 'Test If the correct template was rendered' do
      expect(response).to render_template(:index)
    end
    it 'Test If response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'Test If the response body includes correct placeholder text' do
      expect(response.body).to include('Recipes')
    end
  end

  describe 'Test Get recipes#show' do
    before(:each) do
      sign_in user
      get "/recipes/#{recipe.id}"
    end
    it 'Test If the correct template was rendered' do
      expect(response).to render_template(:show)
    end
    it 'Test If response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'Test If the response body includes correct placeholder text' do
      expect(response.body).to include(recipe.name)
    end
  end
end
