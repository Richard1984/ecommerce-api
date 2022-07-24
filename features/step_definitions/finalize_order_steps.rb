data = {
    firstname: "Paolo",
    lastname: "Paoloni",
    email: "test@test.com",
    password: "JustAnotherTestMan"
}

Given ("I am not authenticated") do
    # visit('/users/sign_out') # ensure that at least
end

Given ("I am a test user") do
    # Create a test user if it doesn't exist
    if User.where(email: data[:email]).count == 0
        user = User.create!(data)
    end

    # # Visit login page and login
    # visit "/login"
    # fill_in "email", :with => data[:email]
    # fill_in "password", :with => data[:password]
    # click_button "Login"

    # # Check if changed location to /
    # max_attempts = 60
    # while current_path != "/" && max_attempts > 0
    #     puts User.where(email: data[:email]).count
    #     puts User.where(email: data[:email]).first.inspect
    #     sleep 1
    #     max_attempts -= 1
    # end
end

Given('I have items in my cart') do
    # Get cart of current user
    user = User.where(email: data[:email]).first

    products = Cart.where(user_id: user.id)
    if products.count == 0
        # Pick and add a product to the cart with available quantity > 0
        product = Product.where("availability > 0").first
        # If no product found, create one
        if product == nil
            product = Product.create(name: "Test Product", description: "This is a test product", price: 10, availability: 10)
        end
        Cart.create(user_id: user.id, product_id: product.id, quantity: 1)
    end
    
end
  
Given('I have inserted my informations for the checkout') do
    # Visit payment page and fill in the informations
    # Set up headers for request
    user = User.where(email: data[:email]).first
    token = user.generate_jwt
    puts token

    visit "/"
    execute_script "window.localStorage.setItem('access_token', '#{token}');"
    visit "/payment"


    # Fill user information fileds
    fill_in "firstname", :with => "Paolo"
    fill_in "lastname", :with => "Paoloni"
    fill_in "address", :with => "Piazza dei Paoloni"
    fill_in "house_number", :with => "1"
    fill_in "city", :with => "Roma"
    fill_in "zip", :with => "00100"
    fill_in "country", :with => "Italia"

    # Fill Stripe fields
    fill_in "card_number", :with => "4242424242424242"
    fill_in "card_cvc", :with => "123"
    fill_in "card_exp_month", :with => "12"
    fill_in "card_exp_year", :with => "2025"
end

When('I click the button "Paga"') do
    click_button "Paga"
end

Then('I should be able to see the order details') do
    pending # Write code here that turns the phrase above into concrete actions
end