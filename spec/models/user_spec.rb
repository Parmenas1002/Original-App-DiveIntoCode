require 'rails_helper'

RSpec.describe User, type: :model do   
    describe 'Test for User model' do
        context 'Create User without name, email and password' do
            it "It's hard to Validation" do
                user = User.new(name: '', email: '')
                expect(user).not_to be_valid
            end
        end
        context 'Create User without password' do
            it 'Validation is caught.' do
                user = User.new(name: "My name", email: "mail@gmail.com", password:"" )
                expect(user).not_to be_valid
            end
        end
        context 'Create User without all informations' do
            it 'Validation passes' do
                user = User.new(name: "My name", email: "mail@gmail.com", password:"password" )
                expect(user).to be_valid
            end
        end
    end 
end