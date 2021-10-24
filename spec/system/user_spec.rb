require 'rails_helper'
def login 
    visit new_user_session_path
    fill_in 'user[email]', with: "from@example.com"
    fill_in 'user[password]', with: "password"
    click_button I18n.t('views.messages.signIn')
end
RSpec.describe 'User profile management function', type: :system do
  describe 'User profile Page' do
    let!(:user) { FactoryBot.create(:user) }
    context 'When the user tries to see his profile' do
        it "You can jump to your details screen " do
            login()
            click_on I18n.t('views.messages.profile')       
            expect(page).to have_content "Name"    
            expect(page).to have_content "from@example.com"  
        end
    end
    context 'When you tried to update your profile' do
        it 'You can change your information ' do
            login()
            visit edit_user_registration_path
            fill_in 'user[email]', with: "newemail@gmail.com"
            fill_in 'user[current_password]', with: "password"
            click_on I18n.t('views.buttons.update')
            click_on I18n.t('views.messages.profile')         
            expect(page).to have_content "newemail@gmail.com"  
        end
    end
    context 'When the general user tries to access to admin page and ' do
        it "You jump on error 500 pages " do
            login()    
            visit rails_admin_path
            expect(page).to have_content "We're sorry, but something went wrong. ERROR 500"         
        end
    end
  end
end