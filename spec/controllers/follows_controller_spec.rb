require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:seller) {FactoryBot.create(:seller)}
  let(:buyer) {FactoryBot.create(:buyer)}

  subject {
    begin
      post :follow, params: {id: seller.id}
    rescue ActionView::MissingTemplate
    end
  }

  describe 'Follow' do
    context "when user is not signed in" do
      it "return status 302" do
        post :follow, params: {id: seller.id}
        expect(response.status).to eq(302)
      end
    end

    context "when user is signed in" do
      it "should increase follow count by one" do
        sign_in buyer
        expect { subject }.to change(Follow, :count).by(1)
      end

      it "should find followed seller" do
        sign_in buyer
        subject
        expect(assigns(:seller)).to be_an_instance_of(Seller)
      end
    end
  end

  describe 'Unfollow' do

    subject {
      begin
        post :unfollow, params: {id: seller.id}
      rescue ActionView::MissingTemplate
      end
    }

    context "when user is not signed in" do
      it "return status 302" do
        post :follow, params: {id: seller.id}
        expect(response.status).to eq(302)
      end
    end

    context "when user is signed in" do
      it "should decrease follow count by one" do
        sign_in buyer
        expect { subject }.to change(Follow, :count).by(0)
      end

      it "should find unfollowed seller" do
        sign_in buyer
        subject
        expect(assigns(:seller)).to be_an_instance_of(Seller)
      end
    end
  end

  describe "Following" do
    context "when user is not signed in" do
      it "returns status 302" do
        get :followings
        expect(response.status).to eq(302)
      end

      it "returns nil in list for following" do
        get :followings
        expect(assigns(:followings)).to eq(nil)
      end
    end

    context "when user is signed in" do
      it "returns list of followings" do
        sign_in buyer
        subject
        get :followings
        expect(assigns(:followings)).to eq([seller])
      end
    end
  end

end
