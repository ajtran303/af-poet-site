require "rails_helper"

RSpec.describe "About Page Spec" do
  before :each do
    @about_text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    @about = About.create(description: @about_text)
  end

  describe "As a visitor" do
    it "I can visit the about page" do
      visit about_index_path
      expect(page).to have_content("About")
      expect(page).to have_content(@about_text)
      expect(page).to_not have_link("Edit")
    end
  end

  describe "As the logged in admin" do
    before :each do
      @user = User.create(email: 'poet@example.com', password: 'securepassword')
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
    end

    it "There is an edit button on /admin/about" do
      visit "/admin/about"
      expect(page).to have_content("About")
      expect(page).to have_content(@about_text)
      expect(page).to have_link("Edit", href: edit_admin_about_path(@about))
    end

    it "There is not an edit button on /about" do
      visit about_index_path
      expect(page).to have_content("About")
      expect(page).to have_content(@about_text)
      expect(page).to_not have_link("Edit")
    end
  end
end
