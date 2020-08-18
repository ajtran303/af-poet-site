require "rails_helper"

RSpec.describe About do
  describe "validations" do
    it { should validate_presence_of :description }
  end
end
