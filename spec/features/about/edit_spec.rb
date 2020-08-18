require "rails_helper"

RSpec.describe "Edit About Page Spec" do
  before :each do
    @about_text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    @about = About.create(description: @about_text)

    @user = User.create(email: 'poet@example.com', password: 'securepassword')
    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log In'
  end

  describe "As the admin" do
    it "I can edit the About page" do
      visit admin_about_index_path
      expect(page).to have_content(@about_text[0...10])

      click_link "Edit", href: "/admin/about/#{@about.id}/edit"

      fill_in "about[description]", with: "Roaming Livestock"
      click_button "Update"

      expect(current_path).to eq(admin_about_index_path)
      expect(page).to_not have_content(@about_text[0...10])
      expect(page).to have_content("Roaming Livestock")
    end
  end
end
