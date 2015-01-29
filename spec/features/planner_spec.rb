require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature 'Planner', js: true do
  context 'with an already logged in user' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    # scenario 'adding homework should show up on planner' do
    #   visit '/'
    #   fill_in 'Email', with: @user.email
    #   fill_in 'Password', with: @user.password
    #   click_button 'Login!'
    #
    #   click_button 'Add Homework'
    #   fill_in 'Title', with: 'Homework Title'
    #   fill_in 'Subject', with: 'Math'
    #   fill_in 'Description', with: 'Multi\nLine\nDescription'
    #   fill_in 'Due Date', with: '22 January, 2015'
    #   click_button 'Create Homework'
    #   expect(page).to_not have_content('Title')
    #   expect(page).to_not have_content('Subject')
    #   expect(page).to_not have_content('Description')
    #   expect(page).to_not have_content('Due Date')
    #   expect(page).to have_content('Homework Title')
    #   expect(page).to have_content('Math')
    # end
  end
end
