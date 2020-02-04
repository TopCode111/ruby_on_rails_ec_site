require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

    let(:seller) {FactoryBot.create(:seller)}
    let(:seller_profile){ FactoryBot.create(:seller_profile, seller: seller)}
    let(:buyer) {FactoryBot.create(:buyer)}
    let(:brand) {FactoryBot.create(:brand)}
    let(:category) {FactoryBot.create(:category)}
    let(:sub_category) {FactoryBot.create(:sub_category, category: category)}
    let!(:item) {FactoryBot.create(:item, category: category, sub_category: sub_category, seller: seller, brand:  brand)}

  describe "#show" do
    context "when item is present" do
      it "returns http success when item is present" do
        get :show, params: {id: item.id}
        expect(response).to have_http_status(:success)
      end

      it "renders show page when item is present" do
        get :show, params: {id: item.id}
        expect(response).to render_template("show")
      end
    end

    context "when item is not present" do
      it "throws 404 page when item is not present" do
        get :show, params: {id: "fake"}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#index" do
    context "when category is visited" do
      it "returns http success for category" do
        get :index, params: {category_name: category.title}
        expect(response).to have_http_status(:success)
      end

      it "returns items of category" do
        get :index, params: {category_name: category.title}
        expect(assigns(:items)).to eq([item])
      end
    end

    context "when sub_category is visited" do
      it "returns http success for sub_category" do
        get :index, params: {category_name: category.title, sub_category_name: sub_category.name}
        expect(response).to have_http_status(:success)
      end

      it "returns items of sub_category" do
        get :index, params: {category_name: category.title, sub_category_name: sub_category.name}
        expect(assigns(:items)).to eq([item])
      end
    end

    context "when brand is visited" do
      it "returns http success for brands" do
        get :index, params: {brand_name: brand.name}
        expect(response).to have_http_status(:success)
      end

      it "returns items of brand" do
        get :index, params: {brand_name: brand.name}
        expect(assigns(:items)).to eq([item])
      end
    end
  end

  describe "#search" do
    context "when search page is visited" do
      it "returns http success for search" do
        get :search
        expect(response).to have_http_status(:success)
      end
    end
  end
end

