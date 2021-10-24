require 'rails_helper'

RSpec.feature 'User signs out' do
  scenario 'user signed in' do
    user = create :user

    sign_in user

    visit root_path

    click_link I18n.t('views.messages.logout')

    expect(page).to have_no_link I18n.t('views.messages.logout')
    expect(page).to have_current_path root_path
  end
end
