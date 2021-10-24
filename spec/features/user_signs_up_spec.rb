require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'with valid data' do
    visit new_user_registration_path

    fill_in 'user[name]', with: 'My name'
    fill_in 'user[email]', with: 'username@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button I18n.t('views.messages.signUp')

    expect(page).to have_link I18n.t('views.messages.logout')
    expect(page).to have_current_path dashboard_path
  end

  scenario 'with invalid data' do
    visit new_user_registration_path

    click_button I18n.t('views.messages.signUp')

    expect(page).to have_no_link I18n.t('views.messages.logout')
  end
end
