require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    let(:seller) { FactoryBot.create(:seller)}
    let(:category) { FactoryBot.create(:category) }
    let(:brand) {FactoryBot.create(:brand)}

    context "when seller is present" do
      it "returns http success" do
        get :show, params: {seller_id: seller.id}
        expect(response).to have_http_status(:success)
      end
      it "renders show page" do
        get :show, params: {seller_id: seller.id}
        expect(response).to render_template("show")
      end
      it 'returns sender profile content' do
        get :show, params: {seller_id: seller.id}
        expect(assigns[:seller]).to eq(seller)
      end

      it 'returns sender items list' do
        item = FactoryBot.create(:item, seller: seller, brand: brand, category: category)
        get :show, params: {seller_id: seller.id}
        expect(assigns[:items]).to eq([item])
      end

      it 'returns published items list' do
        item = FactoryBot.create(:item, seller: seller, brand: brand, category: category, publish: false)
        get :show, params: {seller_id: seller.id}
        expect(assigns[:items]).to eq([])
      end
    end

    context "when seller is not present/hide" do
      it "throws 404 page on not present" do
        get :show, params: {seller_id: 100}
        expect(response.status).to eq(404)
      end

      let(:seller1) { FactoryBot.create(:seller_hide)}
      it "throws 404 page on hide" do
        get :show, params: {seller_id: seller1.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET #validate_email_uniqueness" do
    it 'should return true if email valid' do
      get :validate_email_uniqueness, params: {user: {email: 'ransa@jyaasa.com'}}, format: :json
      response.body.should == 'true'
    end

    it 'should return false if email is not valid' do
      buyer = FactoryBot.create(:buyer, email: 'rasnashakya@gmail.com')
      get :validate_email_uniqueness, params: {user: {email: 'rasnashakya@gmail.com'}}, format: :json
      response.body.should == 'false'
    end
  end

  describe "GET #forgot_password_authorization" do
    it 'should return true if email is present' do
      buyer = FactoryBot.create(:buyer, email: 'rasnashakya@gmail.com')
      get :forgot_password_authorization, params: {user: {email: 'rasnashakya@gmail.com'}}, format: :json
      response.body.should == 'true'
    end

    it 'should return false if email is not present' do
      get :forgot_password_authorization, params: {user: {email: 'rasna@gmail.com'}}, format: :json
      response.body.should == 'false'
    end
  end

  describe 'GET #success' do
    context 'user signed in' do
      it 'should render success page' do
        buyer = FactoryBot.create(:buyer, email: 'rasnashakya@gmail.com')
        sign_in buyer
        get :success
        expect(response).to render_template("success")
      end
    end

    context 'user not signed in' do
      it 'should render sign up page' do
        get :success
        expect(response).to redirect_to("/users/sign_in")
      end

      it 'should return status 401' do
        get :success
        expect(response.status).to eq(302)
      end
    end
  end
end
