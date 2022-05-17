require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'Rida', email: 'example@mail.com', password: 'password') }
  let(:food) { Food.create(user: user, name: 'Apple', measurement_unit: 'kg', price: 12) }

  describe 'Validations' do
    context 'when valid' do
      it { expect(food).to be_valid }
    end

    it 'should allow valid name' do
      food.name = 'Eg'
      expect(food).to_not be_valid
    end

    it 'should allow valid name' do
      food.name = 'Egg'
      expect(food).to be_valid
    end

    it 'should validate measurment unit' do
      food.measurement_unit = nil
      expect(food).to_not be_valid
    end

    it 'should validate measurment unit' do
      food.measurement_unit = 'kg'
      expect(food).to be_valid
    end

    it 'should validate price' do
      food.price = -5
      expect(food).to_not be_valid
    end

    it 'should validate price' do
      food.price = 0
      expect(food).to_not be_valid
    end

    it 'should validate price' do
      food.price = 6
      expect(food).to be_valid
    end
  end
end
