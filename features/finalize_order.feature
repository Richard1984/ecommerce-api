Feature: Finalize order
  As a registered user
  So that i can complete my shopping
  I want to finalize my order

  Background: User Authenticates
    Given test user is created
    Given I am authenticated as test user

  Scenario: Stripe payment and webhook integration
    Given test product is created
    Given I have items in my cart
    Given I started a checkout session
    When I confirm a payment
    Then Stripe Webhook confirms payment