require "rails_helper"

RSpec.describe "Admin Dashboard Index Page Spec" do
  describe "As the logged in admin" do
    before :each do
      @user = User.create(email: 'poet@example.com', password: 'securepassword')
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log In'
    end

    it "I can access the admin dashboard" do
      expect(current_path).to eq(admin_dashboard_index_path)
    end

    it "I see links to edit the site" do
      expect(page).to have_link("Edit About Page", href: "/admin/about/1/edit")

    end

    it "The navbar links to resources under the admin namespace" do
      within ".navbar" do
        expect(page).to have_link("Home", href: "/")
        expect(page).to have_link("Poems", href: "/admin/poems")
        expect(page).to have_link("About", href: "/admin/about")
        expect(page).to have_link("Events", href: "/admin/events")
        expect(page).to have_link("Media", href: "/admin/media")

        expect(page).to have_link("Dashboard", href: admin_dashboard_index_path)

        expect(page).to_not have_link("Poems", href: "/poems")
        expect(page).to_not have_link("About", href: "/about")
        expect(page).to_not have_link("Events", href: "/events")
        expect(page).to_not have_link("Media", href: "/media")
      end
    end
  end

  describe "As a visitor" do
    it "I cannot access the admin dashboard" do
      visit admin_dashboard_index_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    it "There are no links referencing the admin namespace in the navbar" do
      expect(page).to_not have_link("Poems", href: "/admin/poems")
      expect(page).to_not have_link("About", href: "/admin/about")
      expect(page).to_not have_link("Events", href: "/admin/events")
      expect(page).to_not have_link("Media", href: "/admin/media")
      expect(page).to_not have_link("Dashboard", href: admin_dashboard_index_path)
    end
  end

end
