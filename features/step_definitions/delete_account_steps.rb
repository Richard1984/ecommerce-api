data = {
    firstname: "Test",
    lastname: "User",
    email: "test@test.com",
    password: "password"
}

Given ("I am a test user1") do
    @test_user = User.create!({firstname: data[:firstname], lastname: data[:lastname], email: data[:email], password: data[:password], stripe_customer: Stripe::Customer.create()['id']},)
end

Given ("I am authenticated") do
    @session = Capybara::Session.new(:selenium)

    @session.visit('/login')
    @session.fill_in "email", :with => data[:email]
    @session.fill_in "password", :with => data[:password]
    @session.click_button "Login"
end

Given ("I have a cart, lists, reviews, votes and orders") do
    test_product = Product.create!(name: "Test Product", availability: 10, price: "1.48", description: "Description", category_id: nil, available: true)

    Cart.create!(user_id: @test_user.id, product_id: test_product.id, quantity: 1)

    test_product = List.create!(user_id: @test_user.id, name: "Test List")
    ListsEntry.create!(list_id: test_product.id, product_id: test_product.id)

    Review.create!(stars: 4, comments: "Test review", user_id: @test_user.id, product_id: test_product.id)

    # Creo altro user per fare una recensione a cui il test user mette il voto
    other_user = User.create!({firstname: "Test2", lastname: "User2", email: "other@user.com", password: "password123", stripe_customer: Stripe::Customer.create()['id']},)
    other_review = Review.create!(stars: 4, comments: "Review to vote", user_id: other_user.id, product_id: test_product.id)

    Vote.create!(review_id: other_review.id, user_id: @test_user.id, likes: true)

    # Ordine
    order = Order.create!(user_id: @test_user.id, payment_status: :paid_not, shipping_status: :shipped_not)
    OrderProduct.create!(order_id: order.id, product_id: test_product.id, quantity: 1)

    # Non so se necessario
    expect(Product.where(name: "Test Product").count).to eq(1)
    expect(Cart.where(user_id: @test_user.id, product_id: test_product.id, quantity: 1).count).to eq(1)
    expect(ListsEntry.where(list_id: test_product.id, product_id: test_product.id).count).to eq(1)
    expect(Review.where(product_id: test_product.id).count).to eq(2)
    expect(Vote.where(user_id: @test_user.id).count).to eq(1)
end
  
Given('I am in my account page') do
    @session.visit("/account")
end

When('I click the button "Elimina account"') do
    # Non me lo vede come bottone quindi non me lo fa cliccare
    @session.click_link("Elimina account")
    @session.fill_in "password", :with => data[:password]
    @session.click_button "Elimina"
    # Aggiungere parte in cui metto password
end



Then('I should be logged out') do
    expect(@session.current_path()).to eq("/login")
end

Then('my account should be deleted') do
    expect(User.where(email: data[:email]).count).to eq(0)
end
  
Then('my cart should be deleted') do
    expect(Cart.where(user_id: @test_user.id).count).to eq(0)
end
  
Then('my lists should be deleted') do
    expect(List.where(user_id: @test_user.id).count).to eq(0)
end
  
Then('my reviews should be deleted') do
    expect(Review.where(user_id: @test_user.id).count).to eq(0)
end
  
Then('my votes should be deleted') do
    expect(Vote.where(user_id: @test_user.id).count).to eq(0)
end
  
Then('my orders should be kept') do
    expect(Order.all.count).to eq(1)
    expect(OrderProduct.all.count).to eq(1)
end