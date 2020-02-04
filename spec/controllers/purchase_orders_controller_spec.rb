require 'rails_helper'

RSpec.describe PurchaseOrdersController, type: :controller do
  let(:category) { FactoryBot.create(:category) }
  let(:brand) {FactoryBot.create(:brand)}
  let(:size) {FactoryBot.create(:size)}
  let(:seller) { FactoryBot.create(:seller)}
  let(:buyer) { FactoryBot.create(:buyer)}
  let(:item) { FactoryBot.create(:item, seller: seller, brand: brand, category: category)}
  let(:quantity) {FactoryBot.create(:quantity, size: size, item: item)}
  let(:purchase_order) { FactoryBot.create(:purchase_order, buyer_id: buyer.id, seller: seller, item: item, size: size, quantity: quantity, purchase_date: Time.current) }

  describe "GET #index" do

    context 'When buyer is signed in' do

      it "returns 200" do
        sign_in buyer
        get :index
        expect(response.status).to be(200)
      end
    end

    context 'When buyer is not signed in' do
      it "should render user to sign in page" do
        get :index

        expect(response).to redirect_to("/users/sign_in")
      end

      it "should returns status 302" do
        get :index
        expect(response.status).to be(302)
      end
    end
  end
end
