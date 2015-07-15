require 'rails_helper'

RSpec.describe "Trends", type: :request do
  describe "GET /trends" do
    it "works! (now write some real specs)" do
      get trends_path
      expect(response).to have_http_status(200)
    end
  end
end
