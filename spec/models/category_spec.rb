require 'rails_helper'
RSpec.describe Category, type: :model do
    
    describe 'Test for category model' do
        context 'Create Category without name' do
            it "It's hard to Validation" do
                category = Category.new(name: '')
                expect(category).not_to be_valid
            end
        end
        context 'Create Category with name' do
            it 'Validation passes.' do
                category = Category.new(name: "Title")
                expect(category).to be_valid
            end
        end
    end 
end
