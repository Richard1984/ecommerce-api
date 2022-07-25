Feature: Facebook login
  As a facebook user
  So that i can easily login
  I want to logit with facebook oauth

  Background: User Authenticates
    Given I am not authenticated1

  Scenario: I log in with Facebook
    Given I am in the login page
    When I click the button "Entra con Facebook"
    And I log in Facebook
    Then I should be logged in with my facebook account
