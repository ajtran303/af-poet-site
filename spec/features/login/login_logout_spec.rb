require 'rails_helper'

RSpec.describe 'User Login and Log Out' do
  before :each do
    @user = User.create(email: 'poet@example.com', password: 'securepassword')
  end

  describe 'A registered user can log in' do
    it 'with correct credentials' do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      expect(current_path).to eq(admin_dashboard_index_path)
      expect(page).to have_content("Logged in as Poet")
    end

    it 'users already logged in will be redirected' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit login_path

      expect(current_path).to eq(admin_dashboard_index_path)
      expect(page).to have_content('You are already logged in!')
    end
  end

  describe 'Can not log in with bad credentials' do
    it 'incorrect email' do
      visit login_path

      fill_in 'Email', with: 'not_poet@email.com'
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      expect(page).to have_content('Your email or password was incorrect!')
      expect(page).to have_button('Log In')
    end

    it 'incorrect password' do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'bad password'
      click_button 'Log In'

      expect(page).to have_content('Your email or password was incorrect!')
      expect(page).to have_button('Log In')
    end
  end

  describe 'A logged in user can log out' do
    it 'By visiting the log out path' do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'

      click_link 'Log Out'

      expect(current_path).to eq(root_path)
      expect(page).to_not have_content("Logged in as Poet")
      expect(page).to have_content('You have been logged out!')
    end
  end
end
