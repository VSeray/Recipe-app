require 'rails_helper'

RSpec.feature 'Food Index', type: :feature do
  before(:each) do
    @user = User.create(name: 'Testing', email: 'user@example.com', password: 'password')
    @food = Food.create(name: 'apple', measurement_unit: 'kg', price: 10, user: @user)
    visit user_session_path
    fill_in 'email', with: 'user@example.com'
    fill_in 'pwd', with: 'password'
    click_button 'Log in'
  end

  it 'user can see inputs and button' do
    visit user_session_path
    expect(page).to have_current_path(root_path)
  end

  it 'check the user image' do
    expect(page).to have_selector('a')
  end
end
