require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should create users' do
      expect(User.create).to be_a User
    end

    it 'is valid with valid attributes' do
      @user = User.create(first_name: "test", last_name: "test", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
    end

    it 'is not valid if password and password confirmation dont match' do
      @user = User.create(first_name: "test", last_name: "test", email: "test@test.com", password: "password", password_confirmation: "test")
      expect(@user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
      expect(@user).to_not be_valid
    end

    it 'is not valid if password is missing' do
      @user = User.create(first_name: "test", last_name: "test", email: "test@test.com", password: nil, password_confirmation: "password")
      # puts @user.errors.full_messages
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid if the email is already in use' do
      @user1 = User.create(first_name: "test", last_name: "test", email: "test@test.com", password: "password", password_confirmation: "password")
      @user2 = User.create(first_name: "test", last_name: "test", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to eq ["Email has already been taken"]
    end

  end

end
