require 'rails_helper'

RSpec.describe Product, type: :model do
	describe 'Validations' do
		it 'should save correctly when all 4 fields are set' do 
			product = Product.new
			product.name = 'Socks'
			product.price = 10
			product.quantity = 5
			product.category = Category.new
			product.save!
		end
		it 'should have a name' do
			product = Product.new
			product.price = 10
			product.quantity = 5
			product.category = Category.new
			product.save
			expect(product.errors.full_messages).to include("Name can't be blank")
		end
		it 'should have a price' do
			product = Product.new
			product.name = 'Socks'
			product.quantity = 5
			product.category = Category.new
			product.save
			expect(product.errors.full_messages).to include("Price can't be blank")
		end
		it 'should have a quantity' do
			product = Product.new
			product.name = 'Socks'
			product.price = 10
			product.category = Category.new
			product.save
			expect(product.errors.full_messages).to include("Quantity can't be blank")
		end
		it 'should have a category' do
			product = Product.new
			product.name = 'Socks'
			product.price = 10
			product.quantity = 5
			product.save
			expect(product.errors.full_messages).to include("Category can't be blank")
		end
	end
end
