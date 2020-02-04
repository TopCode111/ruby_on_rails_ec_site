require "rails_helper"

RSpec.describe UserNotifierMailer, type: :mailer do
  let(:buyer) { FactoryBot.create(:buyer)}
  let(:seller) { FactoryBot.create(:seller)}
  let(:category) { FactoryBot.create(:category) }
  let(:brand) {FactoryBot.create(:brand)}
  let(:size) {FactoryBot.create(:size)}
  let(:item) { FactoryBot.create(:item, seller: seller, brand: brand, category: category)}
  let(:quantity) {FactoryBot.create(:quantity, size: size, item: item)}
  let(:purchase_order) {FactoryBot.create(:purchase_order, buyer: buyer, purchase_date: Time.current, sum_price: 500, sum_shipping_fees: 10, total_price: 510, billing_address_1: 'ktm', billing_address_2: 'np', billing_prefecture:'www')}
  let(:order_item) {FactoryBot.create(:order_item,
                                      buyer: buyer,
                                      seller: seller,
                                      item: item,
                                      quantity: quantity,
                                      purchase_order: purchase_order)}

  describe "send_buyer_purchase_info" do
    let(:mail) { UserNotifierMailer.send_buyer_purchase_info(purchase_order) }

    it "renders the headers" do
      expect(mail.subject).to eq("【Pick】ご注文ありがとうございます（自動送信メール）")
      expect(mail.to).to eq([buyer.email])
    end
  end

  describe "send_admin_purchase_info" do
    let(:mail) { UserNotifierMailer.send_admin_purchase_info(purchase_order) }

    it "renders the headers" do
      expect(mail.subject).to eq("【Pick】注文が確定しました（自動送信メール)")
      expect(mail.to).to eq(["rasna@jyaasa.com"])
    end
  end
end
