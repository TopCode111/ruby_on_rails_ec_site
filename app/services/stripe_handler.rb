require 'stripe'

class StripeHandler

  # create stripe customer
  def create_customer(email, token)
    Stripe::Customer.create(email: email, source: token)
  rescue => e
    raise e
  end

  def retrieve_customer(stripe_customer_id)
    Stripe::Customer.retrieve(stripe_customer_id)
  rescue Stripe::InvalidRequestError => e
    body = e.json_body
    err  = body[:error]

    Rails.logger.error "Status is: #{e.http_status}"
    Rails.logger.error "Type is: #{err[:type]}"
    Rails.logger.error "Message is: #{err[:message]}"
    false
  end

  def create_card(stripe_customer_id, token)
    customer = retrieve_customer(stripe_customer_id)
    card = customer.sources.create(source: token)
    customer.default_source = card.id
    customer.save
    card
  rescue => e
    raise e
  end

  def create_charge(stripe_customer_id, amount)
    begin
      @charge = Stripe::Charge.create(amount: amount.to_i,
                                      customer: stripe_customer_id,
                                      currency: 'jpy')
    rescue Exception => e
      raise e
    end
  end
end
