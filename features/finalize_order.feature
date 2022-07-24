Feature: Finalize order
  As a registered user
  So that i can complete my shopping
  I want to finalize my order

  Background: User Authenticates
    Given I am not authenticated
    Given I am a test user

  Scenario: The information inserted is correct
    Given I have items in my cart
    And I have inserted my informations for the checkout
    When I click the button "Paga"
    Then I should be able to see the order details