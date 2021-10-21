require 'rails_helper'

RSpec.feature 'User signs in' do
  scenario 'with valid credentials' do
    user = create :user
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_text 'Signed in successfully.'
    expect(page).to have_link 'Profile'
    expect(page).to have_current_path dashboard_path
  end

  scenario 'with invalid credentials' do
    user = build :user

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_text 'Invalid Email or password.'
    expect(page).to have_no_link 'Profile'
  end
end
