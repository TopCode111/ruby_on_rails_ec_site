require 'rails_helper'

RSpec.describe BuyersController, type: :controller do
  let(:buyer) { FactoryBot.create(:buyer)}
  
  describe 'GET #show' do
    context "Buyer is signed in" do
      it "should redirect to mypage" do
        sign_in buyer
        get :show
        response.should render_template :show 
      end
    end

    context "Buyer is not signed in" do
      it "should redirect to sign in page" do
        get :show
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end

  describe 'Get #shipping_address' do
    context "Buyer is signed in" do
      it "should redirect to shipping address page" do
        sign_in buyer
        get :shipping_address
        response.should render_template :shipping_address 
      end

      it "should get buyer instance" do
        sign_in buyer
        get :shipping_address
        expect(assigns[:buyer]).to eq(buyer) 
      end

      it "should instantiate billing address" do
        sign_in buyer
        get :shipping_address
        expect(assigns[:billing_address]).to be_a(BillingAddress)
        assigns(:billing_address).should be_new_record
      end
    end

    context "Buyer is not signed in" do
      it "should redirect to sign in page" do
        get :shipping_address
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end

  describe 'Patch #update' do
    context 'Buyer is signed in and for billing address update' do

      before(:each) do
        @buyer = buyer
        sign_in @buyer
        process :update, method: :put, params: { id: @buyer.id, buyer: attributes_for(:buyer).merge(billing_address_attributes: {address_1: 'test_address_1', address_2: 'test_address_2'})}
        @buyer.reload
      end

      it { expect(response).to redirect_to address_payments_path }
      it { expect(@buyer.address_1).to eql('test_address_1') }
      it { expect(@buyer.address_2).to eql('test_address_2') }
    end
  end

  describe 'Get #address_payments' do
    context 'Buyer is signed in' do
      it "should redirect to address/payment page" do
        sign_in buyer
        get :address_payments
        response.should render_template :address_payments 
      end

      it "should get billing_address instance" do
        sign_in buyer
        get :address_payments
        expect(assigns[:address]).to eq(buyer.billing_address) 
      end

      it "should get payment instance" do
        sign_in buyer
        get :address_payments
        expect(assigns[:payment]).to eq(buyer.payment_account) 
      end
    end
  end
end
