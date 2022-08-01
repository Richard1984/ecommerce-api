Feature: Delete account
  As a logged user
  So that i can remove my account from the website
  I want to delete my account

  Background: User
    Given I am a test user1
    Given I am authenticated
    Given I have a cart, lists, reviews, votes and orders

  Scenario: I delete my account
    Given I am in my account page
    When I click the button "Elimina account"
    Then I should be logged out
    And my account should be deleted
    And my cart should be deleted
    And my lists should be deleted
    And my reviews should be deleted
    And my votes should be deleted
    And my orders should be kept
