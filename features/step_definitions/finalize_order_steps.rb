StripeMock.start()
data = {
    firstname: "Paolo",
    lastname: "Paoloni",
    email: "test@test.com",
    password: "JustAnotherTestMan",
    stripe_customer: Stripe::Customer.create()['id']
}
user_id = ""
auth_header = ""
payment_intent_id = ""
order_id = ""

Given ("test user is created") do
    @user = User.create(data)
    user_id = @user.id
    expect @user != nil
end

Given ("I am authenticated as test user") do
    # Send a request to the login endpoint with the user"s credentials
    page.driver.post("/users/login", {
        user: {
            email: data[:email],
            password: data[:password]
        }
    })
    # Check that the response is a 200 OK
    expect(page.status_code).to eq(200)
    # Save the Authorization header value for later use
    auth_header = page.driver.response.headers["Authorization"]
    page.driver.header "Authorization", auth_header
    expect auth_header != nil
end

Given("test product is created") do
    # Create a test product
    @product = Product.create(name: "Test Product", price: 10.00, description: "Test Product Description")
    expect @product != nil
end

Given("I have items in my cart") do
    # Add the product to the cart
    @product = Product.first
    @cart = Cart.create(user_id: user_id, product_id: @product.id, quantity: 1)
    expect @cart != nil
end
  
Given("I started a checkout session") do
    # Send a request to the cart endpoint
    page.driver.get("/payment", { "Authorization" => auth_header })
    expect(page.status_code).to eq(200)
    @body = JSON.parse(page.driver.response.body)
    # Get the payment intent id and order id from the response
    payment_intent_id = @body["data"]["payment_intent_id"]
    order_id = @body["data"]["order_id"]
end

When("I confirm a payment") do
    # Create a payment method test card
    @payment_method = Stripe::PaymentMethod.create({
        type: 'card',
        card: {
            number: '4242424242424242',
            exp_month: 7,
            exp_year: 2023,
            cvc: '314',
        },
    })
    # Confirm payment stripe using test card
    @payment_intent = Stripe::PaymentIntent.confirm(payment_intent_id, {
        payment_method: @payment_method.id
    })
    # Send a request to the payment endpoint success client
    page.driver.post("/payment/success/client", {
        order_id: order_id
    })
    expect @payment_intent != nil
end

Then("Stripe Webhook confirms payment") do
    # Create a payment intent succeeded webhook event
    event = StripeMock.mock_webhook_event("payment_intent.succeeded", {
        id: payment_intent_id,
        metadata: {
            user_id: user_id,
            order_id: order_id
        },
        charges: {
            data: [
                {
                    receipt_url: "http://localhost:3000/totally_not_a_real_receipt_url",
                    shipping: {
                        name: "Test Tester",
                        address: {
                            line1: "Viale Test",
                            line2: "123",
                            postal_code: "12345",
                            city: "Città di Test",
                            country: "Italia"
                        }
                    }
                }
            ]
        }
    })
    
    # Sign the event with Stripe and get header
    timestamp = Time.now
    signature = Stripe::Webhook::Signature.compute_signature(
        timestamp,
        event.to_json,
        Rails.application.credentials.stripe_webhook_secret
    )
    header = Stripe::Webhook::Signature.generate_header(
        timestamp,
        signature
    )
    
    # Set stripe signature header
    page.driver.header "Stripe-Signature", header
    page.driver.header "Content-Type", "application/json"
    # Send json event as body of request
    page.driver.post("/payment/success/webhook", event.to_json)

    # Check that the response is a 200 OK
    expect(page.status_code).to eq(200)

    # Check that the order is marked as paid
    @order = Order.find_by(id: order_id, payment_status: :paid)
    expect @order != nil

    StripeMock.stop()
end