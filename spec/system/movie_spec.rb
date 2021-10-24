require 'rails_helper'
def login 
    visit new_user_session_path
    fill_in 'user[email]', with: "from@example.com"
    fill_in 'user[password]', with: "password"
    click_button I18n.t('views.messages.signIn')
end
def second_login 
    visit new_user_session_path
    fill_in 'user[email]', with: "admin@example.com"
    fill_in 'user[password]', with: "password"
    click_button I18n.t('views.messages.signIn')
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
                visit movies_path
                expect(page).to have_content 'movie'
                expect(page).to have_content 'My description'
            end
        end
        context 'When transitioned to any movie details screen' do
            it 'The content of the relevant movie is displayed' do
                login()
                movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                visit movie_path(movie.id)
                expect(page).to have_content 'movie'
            end
        end
        context 'When transitioned to any movie details screen you can add a comment' do
            it 'Comment is displayed on the page' do
                login()
                movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                visit movie_path(movie.id)
                fill_in "comment[content]" , with: "My comment"
                click_on I18n.t('views.buttons.addComment')
                expect(page).to have_content 'My comment'
            end
        end
        
        context 'When transitioned to any movie details screen you can edit a comment' do
            it 'Update Comment is displayed on the page' do
                login()
                @movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                visit movie_path(@movie.id)
                fill_in "comment[content]" , with: "My comment"
                click_on I18n.t('views.buttons.addComment')
                click_on I18n.t('views.buttons.edit')
                fill_in "comment_content_"+ @movie.id.to_s , with: "Comment update"
                click_on I18n.t('views.buttons.updateComment')
                expect(page).to have_content 'Comment update'
            end
        end
        
        context 'When transitioned to any movie details screen you can delete a comment' do
            it 'Delete Comment is not displayed on the page' do
                login()
                @movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                visit movie_path(@movie.id)
                fill_in "comment[content]" , with: "My comment"
                click_on I18n.t('views.buttons.addComment')
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
                visit movie_path(@movie.id)
                click_link I18n.t('views.messages.addFavorite')
                click_on I18n.t('views.messages.profile') 
                expect(page).to have_content 'movie'
                expect(page).to have_content 'My description'
            end
        end

        context 'When transitioned to any movie details screen you can delete movie to your favorites movies' do
            it 'Favorite Movie is not displayed on the profile page in favorites movies session' do
                second_login()
                @movie = FactoryBot.create(:movie, name: 'movie', description: "My description" ,user: user, category: category)
                visit movie_path(@movie.id)
                click_on I18n.t('views.messages.addFavorite')
                click_on I18n.t('views.messages.delFavorite')
                click_on I18n.t('views.messages.profile') 
                expect(page).to have_content I18n.t('views.messages.noFavorites')
            end
        end

        
    end
  
end