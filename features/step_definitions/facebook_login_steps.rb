Given ("I am not authenticated1") do
    # visit('/users/sign_out') # ensure that user is signed out
end
  
Given('I am in the login page') do
    # Visit login page
    @session = Capybara::Session.new(:selenium)

    @session.visit "/login"
end

When('I click the button "Entra con Facebook"') do
    # @session.click_button "Entra con Facebook"
end

When('I log in Facebook') do
    
    # window = @session.windows[1]
    # switch_to_window(window)
    # puts window.current?
    # @session.click_button "Consenti solo i cookie essenziali"
    # @session.fill_in "E-mail o telefono:", :with => ""
    # @session.fill_in "Password:", :with => ""
    # sleep 10
end

Then('I should be logged in with my facebook account') do
    pending # Write code here that turns the phrase above into concrete actions
end