require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    describe "User fields" do
      it "should save successfully with password and password_confirmation being the same" do
        password = "password123"
        @user = User.new(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: password, password_confirmation: password)
        expect(@user).to be_valid
        expect(@user.errors).to be_empty
      end
  
      it "should not save successfully with password and password_confirmation having a mismatch" do
        @user = User.new(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: "password", password_confirmation: "something_else")
        expect(@user).to_not be_valid
        expect(@user.errors).to_not be_empty
      end
  
      it "should not save successfully with name missing" do
        @user = User.new(name: nil, email: "uniqueemailaddress@uniqueemailaddress.com", password: "password", password_confirmation: "password")
        expect(@user).to_not be_valid
        expect(@user.errors).to_not be_empty
      end
  
      it "should not save successfully with email missing" do
        @user = User.new(name: "Test Name", email: nil, password: "password", password_confirmation: "password")
        expect(@user).to_not be_valid
        expect(@user.errors).to_not be_empty
      end
  
      it "should not save successfully with password missing" do
        @user = User.new(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: nil, password_confirmation: "password")
        expect(@user).to_not be_valid
        expect(@user.errors).to_not be_empty
      end
  
      it "should not save successfully with password_confirmation missing" do
        @user = User.new(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: "password")
        expect(@user).to_not be_valid
        expect(@user.errors).to_not be_empty
      end
    end
    
    describe "Email uniqueness" do
      it "should not save successfully with 2 identical emails" do
        password = "password123"
        @user1 = User.create!(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: password, password_confirmation: password)
        expect(User.new(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: password, password_confirmation: password)).to_not be_valid
      end

      it "should save successfully with different emails" do
        password = "password123"
        @user1 = User.create!(name: "Test Name", email: "uniquee@uniqueemailaddress.com", password: password, password_confirmation: password)
        expect(User.new(name: "Test Name", email: "different@uniqueemailaddress.com", password: password, password_confirmation: password)).to be_valid
      end
    end
  
    describe "Password length" do
      it "should not save successfully with a password length of 4" do
        password = "1234"
        @user = User.new(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: password, password_confirmation: password)
        expect(@user).to_not be_valid
      end

      it "should save successfully with a password length of 10" do
        password = "1234567891"
        @user = User.new(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: password, password_confirmation: password)
        expect(@user).to be_valid
      end
    end

  end

  describe '.authenticate_with_credentials' do
    it "should not login auccessfully with the invalid password" do
      password = "valid_password"
      @user = User.create!(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: password, password_confirmation: password)
      @found_user = User.authenticate_with_credentials(@user.email, "wrong_password")
      expect(@found_user).to be_nil
    end

    it "should not login auccessfully with the invalid email" do
      password = "valid_password"
      @user = User.create!(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: password, password_confirmation: password)
      @found_user = User.authenticate_with_credentials("different_email@test.com", password)
      expect(@found_user).to be_nil
    end

    it "should login auccessfully with the correct email and password" do
      password = "valid_password"
      @user = User.create!(name: "Test Name", email: "uniqueemailaddress@uniqueemailaddress.com", password: password, password_confirmation: password)
      @found_user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@found_user).to_not be_nil
      expect(@found_user.id).to equal(@user.id)
    end

    it "should login auccessfully with the correct email and password where the email contains spaces" do
      email = "uniqueemailaddress@uniqueemailaddress.com"
      password = "valid_password"
      @user = User.create!(name: "Test Name", email: email, password: password, password_confirmation: password)
      @found_user = User.authenticate_with_credentials("  " << email, @user.password)
      expect(@found_user).to_not be_nil
      expect(@found_user.id).to equal(@user.id)
    end

    it "should login auccessfully with the correct email and password where the email is in the wrong case" do
      email = "uniqueemailaddress@uniqueemailaddress.com"
      password = "valid_password"
      @user = User.create!(name: "Test Name", email: email, password: password, password_confirmation: password)
      @found_user = User.authenticate_with_credentials("UniqueemailAddress@UniqueemailAddress.Com", @user.password)
      expect(@found_user).to_not be_nil
      expect(@found_user.id).to equal(@user.id)
    end

  end
  
end
