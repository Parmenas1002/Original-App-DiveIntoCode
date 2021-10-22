require 'rails_helper'

RSpec.describe Movie, type: :model do
    
    describe 'Test for Movie model' do
        let!(:user) { FactoryBot.create(:user) }
        let!(:category) { FactoryBot.create(:category) }
        context 'Create Movie without name and description' do
            it "It's hard to Validation" do
                movie = Movie.new(name: '', description: '')
                expect(movie).not_to be_valid
            end
        end
        context 'Create Movie without description' do
            it 'Validation is caught. Here description is not set' do
                movie = Movie.new(name: "Title", description: "")
                expect(movie).not_to be_valid
            end
        end

        context 'Create Movie all informations' do
            it 'Validation passes' do
                movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                expect(movie).to be_valid
            end
        end
    end 
end
