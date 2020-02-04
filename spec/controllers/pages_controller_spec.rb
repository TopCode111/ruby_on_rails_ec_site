require 'rails_helper'

RSpec.describe PagesController, type: :controller do
	describe 'GET #privacy' do
    it 'should render privacy page' do
      get :privacy
      expect(response).to render_template("privacy")
    end
  end

  describe 'GET #terms_condition' do
    it 'should render terms_condition page' do
      get :terms_condition
      expect(response).to render_template("terms_condition")
    end
  end

  describe 'GET #index' do
    let(:seller) { FactoryBot.create(:seller)}
    let(:category) { FactoryBot.create(:category) }
    let(:brand) {FactoryBot.create(:brand)}
    it 'should contain newest item list' do
      item = FactoryBot.create(:item, seller: seller, brand: brand, category: category)
      item2 = FactoryBot.create(:item, seller: seller, brand: brand, category: category, name: 'fashion fever')
      get :index
      expect(assigns[:newest_items]).to eq([item2, item])
    end

    it 'should contain newest item list' do
      item = FactoryBot.create(:item, seller: seller, brand: brand, category: category, purchase_count: 10)
      item2 = FactoryBot.create(:item, seller: seller, brand: brand, category: category, name: 'fashion fever', purchase_count:5)
      get :index
      expect(assigns[:popular_items]).to eq([item, item2])
    end

    it 'should contain famous sellers list' do
      seller1 = FactoryBot.create(:seller, email: 'jasmin@qwerty.com')
      item = FactoryBot.create(:item, seller: seller, brand: brand, category: category, purchase_count: 10)
      item2 = FactoryBot.create(:item, seller: seller1, brand: brand, category: category, name: 'fashion fever', purchase_count:5)
      get :index
      expect(assigns[:famous_sellers]).to eq([seller, seller1])
    end
  end
end
