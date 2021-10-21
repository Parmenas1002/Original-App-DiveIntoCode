require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'with valid data' do
    visit new_user_registration_path

    fill_in 'Name', with: 'My name'
    fill_in 'Email', with: 'username@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_text 'Welcome! You have signed up successfully.'
    expect(page).to have_link 'Logout'
    expect(page).to have_current_path dashboard_path
  end

  scenario 'with invalid data' do
    visit new_user_registration_path

    click_button 'Sign Up'

    expect(page).to have_text "Email can't be blank"
    expect(page).to have_text "Password can't be blank"
    expect(page).to have_no_link 'Logout'
  end
end
