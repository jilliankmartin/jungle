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
      @user = User.create(first_name: "test", last_name: "test", email: "test@test.com", password: "password", password_confirmation: "testtesttest")
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

    it 'should contain a first name' do
      @user = User.create(first_name: nil, last_name: "test", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq ["First name can't be blank"]
    end

    it 'should contain a last name' do
      @user = User.create(first_name: "test", last_name: nil, email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq ["Last name can't be blank"]
    end

    it 'should contain an email' do
      @user = User.create(first_name: "test", last_name: "test", email: nil, password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to eq ["Email can't be blank"]
    end

    it 'should not be valid if the password is under 8 characters' do
    @user = User.create(first_name: "test", last_name: "test", email: "test@test.com", password: "pass", password_confirmation: "pass")
    expect(@user).to_not be_valid
    expect(@user.errors.full_messages).to eq ["Password is too short (minimum is 8 characters)"]
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should not authenticate if credentials dont match' do
      user = User.new(first_name: "test", last_name: "test", email: "test@test.com", password: "password", password_confirmation: "password")
      user.save
      invalid = User.authenticate_with_credentials("testtest@test.com", "password")
      expect(invalid).to_not eq (user)
    end
  end

end
