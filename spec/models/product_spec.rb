require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should create products' do
      expect(Product.new).to be_a Product
    end

    it 'is valid with valid attributes' do
      @category = Category.new(name: "shoes")
      @product = Product.new(id: 200, name: "Red Shoe", price_cents: 2000, quantity: 10, category: @category)
      expect(@product).to be_valid
    end

    it 'should contain a name' do
      @category = Category.new(name: "shoes")
      @product = Product.new(id: 200, name: nil, price_cents: 2000, quantity: 10, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Name can't be blank"]
    end

    it 'should contain a price' do
      @category = Category.new(name: "shoes")
      @product = Product.new(id: 200, name: "Red shoe", price_cents: nil, quantity: 10, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    
    it 'should contain a quantity' do
      @category = Category.new(name: "shoes")
      @product = Product.new(id: 200, name: "Red shoe", price_cents: 2000, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Quantity can't be blank"]
    end

    it 'should contain a category' do
      @category = Category.new(name: "shoes")
      @product = Product.new(id: 200, name: "Red shoe", price_cents: 2000, quantity: 10, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to eq ["Category can't be blank"]
    end

  end
end
