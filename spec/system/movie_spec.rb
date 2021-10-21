require 'rails_helper'
def login 
    visit new_user_session_path
    fill_in 'Email', with: "from@example.com"
    fill_in 'Password', with: "password"
    click_button 'Sign In'
end
def second_login 
    visit new_user_session_path
    fill_in 'Email', with: "admin@example.com"
    fill_in 'Password', with: "password"
    click_button 'Sign In'
end
RSpec.describe 'Movie management function', type: :system do
    include CarrierWave::Test::Matchers
    describe 'List display function' do
        let!(:user) { FactoryBot.create(:user) }
        let!(:category) { FactoryBot.create(:category) }
        let!(:second_user) { FactoryBot.create(:second_user) }
        
        context 'When transitioning to the list screen' do
            it 'All movies is listed on the page' do  
                login()
                movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                movie.image.store!(File.open('spec/fixtures/image1.jpg'))
                visit movies_path
                expect(page).to have_content 'movie'
                expect(page).to have_content 'My description'
            end
        end
        context 'When transitioned to any movie details screen' do
            it 'The content of the relevant movie is displayed' do
                login()
                movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                movie.image.store!(File.open('spec/fixtures/image1.jpg'))
                movie.video.store!(File.open('spec/fixtures/video.mp4'))
                visit movie_path(movie.id)
                expect(page).to have_content 'movie'
            end
        end
        context 'When transitioned to any movie details screen you can add a comment' do
            it 'Comment is displayed on the page' do
                login()
                movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                movie.image.store!(File.open('spec/fixtures/image1.jpg'))
                movie.video.store!(File.open('spec/fixtures/video.mp4'))
                visit movie_path(movie.id)
                fill_in "comment[content]" , with: "My comment"
                click_on "Add new comment"
                expect(page).to have_content 'My comment'
            end
        end
        
        context 'When transitioned to any movie details screen you can edit a comment' do
            it 'Update Comment is displayed on the page' do
                login()
                @movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                @movie.image.store!(File.open('spec/fixtures/image1.jpg'))
                @movie.video.store!(File.open('spec/fixtures/video.mp4'))
                visit movie_path(@movie.id)
                fill_in "comment[content]" , with: "My comment"
                click_on "Add new comment"
                click_on "Edit"
                fill_in "comment_content_"+ @movie.id.to_s , with: "Comment update"
                click_on "Update comment"
                expect(page).to have_content 'Comment update'
            end
        end
        
        context 'When transitioned to any movie details screen you can delete a comment' do
            it 'Delete Comment is not displayed on the page' do
                login()
                @movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                @movie.image.store!(File.open('spec/fixtures/image1.jpg'))
                @movie.video.store!(File.open('spec/fixtures/video.mp4'))
                visit movie_path(@movie.id)
                fill_in "comment[content]" , with: "My comment"
                click_on "Add new comment"
                delete_buttons = all('.delete')  
                page.accept_confirm do
                    delete_buttons[0].click
                end    
                expect(page).to have_content 'Comment delete with success'
            end
        end
        context 'When transitioned to any movie details screen you can add movie to your favorites movies' do
            it 'New favorite Movie is displayed on the profile page in favorites movies session' do
                second_login()
                @movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                @movie.image.store!(File.open('spec/fixtures/image1.jpg'))
                @movie.video.store!(File.open('spec/fixtures/video.mp4'))
                visit movie_path(@movie.id)
                click_link "Add to favorites"
                click_on "Profile" 
                expect(page).to have_content 'movie'
                expect(page).to have_content 'My description'
            end
        end

        context 'When transitioned to any movie details screen you can delete movie to your favorites movies' do
            it 'Favorite Movie is not displayed on the profile page in favorites movies session' do
                second_login()
                @movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                @movie.image.store!(File.open('spec/fixtures/image1.jpg'))
                @movie.video.store!(File.open('spec/fixtures/video.mp4'))
                visit movie_path(@movie.id)
                click_on "Add to favorites"
                click_on "Delete to favorites"
                click_on "Profile" 
                expect(page).to have_content "You don't yave favorites movies yet."
            end
        end

        
    end
  
end