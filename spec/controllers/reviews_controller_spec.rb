require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  let(:seller) {FactoryBot.create(:seller)}
  let(:buyer) {FactoryBot.create(:buyer)}
  let(:size) {FactoryBot.create(:size)}
  let(:payment_account) {FactoryBot.create(:payment_account, buyer: buyer)}
  let(:category) {FactoryBot.create(:category)}
  let(:brand) {FactoryBot.create(:brand)}
  let(:item) {FactoryBot.create(:item, category: category, seller: seller, brand:  brand)}
  let(:quantity) {FactoryBot.create(:quantity, item: item, size: size)}
  let(:purchase_order) {FactoryBot.create(:purchase_order)}
  let(:order_item1) {FactoryBot.create(:order_item,
                                      buyer: buyer,
                                      seller: seller,
                                      item: item,
                                      quantity: quantity,
                                      purchase_order: purchase_order)}
  let(:order_item) {FactoryBot.create(:order_item,
                                      buyer: buyer,
                                      seller: seller,
                                      item: item,
                                      quantity: quantity,
                                      purchase_order: purchase_order,
                                      reviewed: true)}
  let(:review) {FactoryBot.create(:review, item: item, seller: seller, buyer: buyer)}

  describe "#new" do
    it "returns http success" do
      sign_in buyer
      get :new, params: {order_id: order_item.id, id: item.id}
      expect(response).to have_http_status(:success)
    end

    it "create a review instance" do
      sign_in buyer
      get :new, params: {order_id: order_item.id, id: item.id}
      expect(assigns(:review)).to be_a(Review)
    end
  end

  describe "#create" do
    it "allows user to review the item" do
      sign_in buyer
      expect{
        post :create, params: {review: FactoryBot.attributes_for(:review, item_id: item.id,
                                         seller_id: seller.id, buyer_id: buyer.id, order_id: order_item1.id)}
      }.to change(Review, :count).by(1)
      expect(flash[:notice]).to be_present
      expect(response).to redirect_to purchase_history_path
      order_item1.reload
      expect(order_item1.reviewed).to eq(true)
    end

    it "doesn't allow user to review item if buyer is not logged in" do
      expect{
        post :create, params: {review: FactoryBot.attributes_for(:review, item_id: item.id,
                                         seller_id: seller.id, buyer_id: buyer.id, order_id: order_item1.id)}
      }.to change(Review, :count).by(0)
    end

    it "redirects to item review path if already reviewed" do
      sign_in buyer
      post :create, params: {review: FactoryBot.attributes_for(:review, order_id: order_item.id)}
      expect(response).to redirect_to item_review_path(order_item.id, item.id)
    end
  end

end
