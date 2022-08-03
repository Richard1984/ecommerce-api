require 'rails_helper'

RSpec.describe "Payments", type: :request do
  before :all do
    StripeMock.start()
  end

  after :all do
    StripeMock.stop()
  end

  before :each do
    # Create a user
    data = {
        firstname: "Paolo",
        lastname: "Paoloni",
        email: "test@test.com",
        password: "JustAnotherTestMan",
        stripe_customer: Stripe::Customer.create()['id']
    }
    @user = User.create(data)
    @token = @user.generate_jwt
    # Create a product
    @product = Product.create(name: "Test Product", price: 10.00, description: "Test Product Description")
    # Create headers
    @headers = Hash.new
    @headers["Authorization"] = "Bearer #{@token}"
  end


  describe "GET /payment" do
    setup do
      # Create a cart with the test product
      cart = Cart.create(user_id: @user.id, product_id: @product.id, quantity: 1)
    end

    context "get checkout page" do
      it "returns stripe payment id, stripe client secret, shopping cart and order id" do
        get "/payment", :headers => @headers
        
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        
        response_json = JSON.parse(response.body)

        # Check if the payment intent id is correct
        payment_intent = Stripe::PaymentIntent.retrieve(response_json["data"]["payment_intent_id"])
        expect(payment_intent[:id]).to eq(response_json["data"]["payment_intent_id"])

        # Check if the client secret is correct
        expect(payment_intent[:client_secret]).to eq(response_json["data"]["client_secret"])

        # Check cart if is valid
        expect(response_json["data"]["cart"].length).to eq(1)
        expect(response_json["data"]["cart"][0]["quantity"]).to eq(1)
        expect(response_json["data"]["cart"][0]["product"]["name"]).to eq(@product.name)
        expect(response_json["data"]["cart"][0]["product"]["price"].to_i).to eq(@product.price.to_i)
        expect(response_json["data"]["cart"][0]["product"]["description"]).to eq(@product.description)
        
        # Check if the order id is correct
        order = Order.find(response_json["data"]["order_id"])
        expect(order.id).to eq(response_json["data"]["order_id"])

      end
    end
  end

  
  describe "POST /payment/success/client" do
    setup do
      # Create an order with the user
      @order = Order.create(user_id: @user.id, payment_status: :paid_not)
      # Add the test product to the order
      order_product = OrderProduct.create(order_id: @order.id, product_id: @product.id, quantity: 1)
    end

    context "update payment status" do
      it "order paid confirm by client" do
        params = Hash.new
        params["order_id"] = @order.id
        post "/payment/success/client", :headers => @headers, :params => params
        
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        
        response_json = JSON.parse(response.body)

        # Response should be "Done"
        expect(response_json["message"]).to eq("Done")
      end
    end
  end
  

  describe "POST /payment/success/webhook" do
    setup do
      # Create an order with the user
      @order = Order.create(user_id: @user.id, payment_status: :paid_not)
      # Add the test product to the order
      order_product = OrderProduct.create(order_id: @order.id, product_id: @product.id, quantity: 1)
      # Create event
      @shipping = {
        name: "Paolo Paoloni",
        address: {
            line1: "Viale Test",
            line2: "123",
            postal_code: "12345",
            city: "Città di Test",
            country: "Italia"
        }
      }
      @receipt_url = "http://localhost:3000/totally_not_a_real_receipt_url"
      @event = StripeMock.mock_webhook_event("payment_intent.succeeded", {
        metadata: {
          user_id: @user.id,
          order_id: @order.id
        },
        charges: {
          data: [
            {
              receipt_url: @receipt_url,
              shipping: @shipping
            }
          ]
        }
      })
      # Sign the event with Stripe and get header
      timestamp = Time.now
      signature = Stripe::Webhook::Signature.compute_signature(
          timestamp,
          @event.to_json,
          Rails.application.credentials.stripe_webhook_secret
      )
      header = Stripe::Webhook::Signature.generate_header(
          timestamp,
          signature
      )
      @headers["Stripe-Signature"] = header
    end

    context "update payment status" do
      it "order paid confirm by webhook" do
        post "/payment/success/webhook", :headers => @headers, :params => @event.to_json
        
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        
        response_json = JSON.parse(response.body)

        # Response should be "Webhook received."
        expect(response_json["message"]).to eq("Webhook received.")

        # Check if the order is paid
        order = Order.find(@order.id)
        expect(order.payment_status).to eq("paid")
        # Check if the order has a receipt
        expect(order.receipt_url).to eq(@receipt_url)
        # Check if the order has a shipping address
        expect(order.name).to eq(@shipping[:name])
        expect(order.line1).to eq(@shipping[:address][:line1])
        expect(order.line2).to eq(@shipping[:address][:line2])
        expect(order.postal_code).to eq(@shipping[:address][:postal_code])
        expect(order.city).to eq(@shipping[:address][:city])
        expect(order.country).to eq(@shipping[:address][:country])
      end
    end
  end
end
