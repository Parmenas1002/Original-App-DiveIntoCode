require 'rails_helper'
RSpec.describe Favorite, type: :model do
    describe 'Test for Comment model' do
        let!(:user) { FactoryBot.create(:user) }
        let!(:category) { FactoryBot.create(:category) }
        context 'Create Favorite without content, movie and user' do
            it "It's hard to Validation" do
                favorite = Favorite.new()
                expect(favorite).not_to be_valid
            end
        end
        context 'Create Favorite with all informations ' do
            it 'Validation passes.' do
                movie = Movie.new(name: "Title", description: "My description", user: user, category:category)
                favorite = Favorite.new( user: user, movie: movie)
                expect(favorite).to be_valid
            end
        end
    end 
    
end
