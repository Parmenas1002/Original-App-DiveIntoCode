require 'rails_helper'
RSpec.describe Comment, type: :model do
    describe 'Test for Favorite model' do
        let!(:user) { FactoryBot.create(:user) }
        let!(:category) { FactoryBot.create(:category) }
        context 'Create Comment without  movie and user ' do
            it "It's hard to Validation" do
                comment = Comment.new(content: '')
                expect(comment).not_to be_valid
            end
        end
        context 'Create Comment with all informations' do
            it 'Validation passes.' do
                movie = Movie.new(name: "Title", description: "My description", user: user, category:category)
                comment = Comment.new(content: "My content", user: user, movie: movie)
                expect(comment).to be_valid
            end
        end
    end    
end

