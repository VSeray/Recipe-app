require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  include Devise::Test::IntegrationHelpers
  
  let(:user) { User.create(name: 'Cork', email: 'example@mail.com', password: 'password') }

  describe 'Test Get shopping_list#index' do
    before(:each) do
      sign_in user
      get '/general_shopping_list/'
    end
    it 'Test If the correct template was rendered' do
      expect(response).to render_template(:index)
    end
    it 'Test If response status was correct' do
      expect(response).to have_http_status(:ok)
    end
    it 'Test If the response body includes correct placeholder text' do
      expect(response.body).to include('Shopping List')
    end
  end
end
