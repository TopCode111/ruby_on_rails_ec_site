require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do

  describe "GET #not_found" do
    it "returns 404 status code" do
      get :not_found
      expect(response.status).to eq(404)
    end

    it "returns http success" do
      match '/404'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #internal_server_error" do
    it "returns 500 status code" do
      get :internal_server_error
      expect(response.status).to eq(500)
    end

    it "returns http success" do
      match '/500'
      expect(response).to have_http_status(:success)
    end
  end
end
