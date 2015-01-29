require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature 'Login', js: true do
  context 'with an already registered user' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    scenario 'sign in with valid credentials' do
      visit '/'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Login!'

      expect(page).to have_content('LOGOUT')
    end

    scenario 'sign in with invalid credentials' do
      visit '/'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: "#{@user.password}invalid"
      expect(page).to have_content('LOGIN!')
    end
  end
end
