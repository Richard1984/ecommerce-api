data = {
    firstname: "Paolo",
    lastname: "Paoloni",
    email: "test@test.com",
    password: "JustAnotherTestMan"
}

Given ("I already registered") do
    # Create a test user if it doesn't exist
    if User.where(email: data[:email]).count == 0
        visit "/signup"
        fill_in "firstname", with: data[:firstname]
        fill_in "lastname", with: data[:lastname]
        fill_in "email", with: data[:email]
        fill_in "password", with: data[:password]
        click_button "Registrati"
    else
        visit "/"
    end
    
    # Check if changed location to /
    max_attempts = 60
    while current_path != "/" && max_attempts > 0
        sleep 1
        max_attempts -= 1
    end

    # Check if the user exists
    expect(User.where(email: data[:email]).count).to eq(1)
end

Given ("I am logged in") do
    visit "/"

    sleep 5 # TODO replace with a better wait 
    # If the user is not logged in, log him in
    if page.has_content?("Accedi")
        click_link "Accedi"

        # Wait for the login form to be visible
        max_attempts = 600
        while page.has_content?("Login") == false && max_attempts > 0
            sleep 0.1
        end
        fill_in "email", with: data[:email]
        fill_in "password", with: data[:password]
        click_button "Login"
    end

    # Check if changed location to /
    max_attempts = 60
    while current_path != "/" && max_attempts > 0
        sleep 1
        max_attempts -= 1
    end
    expect(current_path).to eq("/")
end

# Given('I have items in my cart') do
#     visit "/"

#     # Get cart of current user
#     user = User.where(email: data[:email]).first
#     sleep 10
#     if Cart.where(user_id: user.id).count == 0
#         # Click one of the products and add it to the cart
#         click_button "Aggiungi al carrello"
#     end

#     # Check if the cart is not empty
#     # expect(Cart.where(user_id: user.id).count).to eq(1)
# end

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
    visit "/"

    # Click on the cart
    click_link "Carrello"
    # Click on the checkout button
    click_link "Vai al checkout"    

    # Wait for the page to load
    max_attempts = 60
    while page.body.include?("Loading...") && max_attempts > 0
        sleep 1
        max_attempts -= 1
    end

    # Fill user information fileds
    fill_in "firstname", :with => "Paolo"
    fill_in "lastname", :with => "Paoloni"
    fill_in "address", :with => "Piazza dei Paoloni"
    fill_in "house_number", :with => "1"
    fill_in "city", :with => "Roma"
    fill_in "zip", :with => "00100"
    fill_in "country", :with => "Italia"

    # Wait for Stripe to load
    max_attempts = 15
    while page.body.include?("Card number") && max_attempts > 0
        sleep 1
        max_attempts -= 1
    end

    # Fill Stripe fields
    within_frame 0 do 
        page.driver.browser.find_element(:id, "Field-numberInput").send_keys "4242424242424242"
        page.driver.browser.find_element(:id, "Field-expiryInput").send_keys "04"
        page.driver.browser.find_element(:id, "Field-expiryInput").send_keys "24"
        page.driver.browser.find_element(:id, "Field-cvcInput").send_keys "123"
    end
end

When('I click the button "Paga"') do
    click_button "Paga"
end

Then('I should be able to see the order details') do
    # Check if changed location to /
    max_attempts = 30
    while page.body.include?("Stato ordine") && max_attempts > 0
        sleep 1
        max_attempts -= 1
    end

    # Check if the order is present
    expect(Order.where(user_id: User.where(email: data[:email]).first.id).count).to eq(1)
end