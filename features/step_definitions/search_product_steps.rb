keyboards = ["Keyboard RGB", "Cheap keyboard", "MechanicalKeyboard"]
non_keyboards = ["Cabbage"]

Given ("There are multiple keyboards in the shop") do
    keyboards.each do |name|
        Product.create!(name: name, availability: 10, price: "1.48", description: "Description", category_id: nil, available: true)
    end
end

Given ("There are non keyboard products in the shop") do
    non_keyboards.each do |name|
        Product.create!(name: name, availability: 10, price: "1.48", description: "Description", category_id: nil, available: true)
    end
end

Given ("I am in the home page") do
    @session = Capybara::Session.new(:selenium, Rails.application) do |config|
        config.app_host   = "http://localhost:3001"
    end

    @session.visit "/"
end

When('I write "keyboard" in the seach bar') do
    @session.fill_in "Cerca prodotti", :with => "keyboard"
end

When("I click on the looking glass icon") do
    @session.click_button("", class: "button_button__zpxkc search-bar_button__58D-N button_button--medium__20rZ6")
end

Then('I should be able to see all products with "keyboard" in the name') do
    keyboards.each do |name|
        expect(@session).to have_content(name)
    end
end

Then('There should be no products without "keyboard" in the name') do
    non_keyboards.each do |name|
        expect(@session).to have_no_content(name)
    end
    @session.quit
end
