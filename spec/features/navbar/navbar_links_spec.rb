require "rails_helper"

RSpec.describe "Navbar Links Spec" do
  describe "As a visitor" do
    describe "On the welcome page" do
      it "There is a navbar" do
        visit root_path

        within ".navbar" do
          expect(page).to have_link("Home", href: "/")
          expect(page).to have_link("Poems", href: "/poems")
          expect(page).to have_link("About", href: "/about")
          expect(page).to have_link("Events", href: "/events")
          expect(page).to have_link("Media", href: "/media")
        end

        within ".login" do
          expect(page).to have_link("Login", href: "/login")
        end
      end
    end
  end
end
