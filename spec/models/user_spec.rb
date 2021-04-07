require 'rails_helper'

RSpec.describe User, type: :model do
	describe 'Validations' do
		it 'should save correctly when all 4 fields are set' do 
			user = User.new
			user.name = 'Jim Halpert'
			user.email = 'jim@gmail.com'
			user.password = 'office'
			user.password_confirmation = 'office'
			user.save!
		end
		describe 'Password confirmation' do
			it 'should have a password' do
				user = User.new
				user.name = 'Jim Halpert'
				user.email = 'jim@gmail.com'
				user.password_confirmation = 'office'
				user.save
				expect(user.errors.full_messages).to include("Password can't be blank")
			end
			it 'should be at least 5 characters long' do
				user = User.new
				user.name = 'Jim Halpert'
				user.email = 'jim@gmail.com'
				user.password = 'pam'
				user.password_confirmation = 'pam'
				expect(user.save).to be false
				user2 = User.new
				user2.name = 'Jim Halpert'
				user2.email = 'jim@gmail.com'
				user2.password = 'office'
				user2.password_confirmation = 'office'
				user2.save!
			end
			it 'should save when password equals password_confirmation' do
				user = User.new
				user.name = 'Jim Halpert'
				user.email = 'jim@gmail.com'
				user.password = 'office'
				user.password_confirmation = 'office'
				user.save!
			end
			it 'should fail when password is different than password_confirmation' do
				user = User.new
				user.name = 'Jim Halpert'
				user.email = 'jim@gmail.com'
				user.password = 'office'
				user.password_confirmation = 'off'
				expect(user.save).to be false
			end
		end
		describe 'Email' do
			it 'should fail if email is already in database' do
				user1 = User.new
				user1.name = 'Jim Halpert'
				user1.email = 'jim@gmail.com'
				user1.password = 'office'
				user1.password_confirmation = 'office'
				user1.save!
				user2 = User.new
				user2.name = 'Jimmy Bob'
				user2.email = 'JIM@gmail.com'
				user2.password = 'jimmy'
				user2.password_confirmation = 'jimmy'
				expect(user2.save).to be false
			end
		end
		it 'should have a name' do
			user = User.new
			user.email = 'jim@gmail.com'
			user.password = 'office'
			user.password_confirmation = 'office'
			user.save
			expect(user.errors.full_messages).to include("Name can't be blank")
		end
		it 'should have an email' do
			user = User.new
			user.name = 'Jim Halpert'
			user.password = 'office'
			user.password_confirmation = 'office'
			user.save
			expect(user.errors.full_messages).to include("Email can't be blank")
		end
	end

	describe '.authenticate_with_credentials' do
		before do 
			@user = User.create(name: 'Jim Halpert', email: 'jim@gmail.com', password: 'office', password_confirmation: 'office')
		end

		it 'should log in if valid credentials are given' do
			user = User.authenticate_with_credentials('jim@gmail.com', 'office')
			expect(user).to eq(@user)
		end
		it 'should not log in if credentials are invalid' do
			user = User.authenticate_with_credentials('jim@gmail.com', 'dundermifflin')
			expect(user).to be nil
		end
		it 'should not have email as case sensitive' do
			user = User.authenticate_with_credentials('JIM@gmail.com', 'office')
			expect(user).to eq(@user)
		end
		it 'should not include whitespace around email' do
			user = User.authenticate_with_credentials('      jim@gmail.com   ', 'office')
			expect(user).to eq(@user)
		end
  end
end
