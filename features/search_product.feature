Feature: Search product
    As a visitor
    So that I can find a product I'm interested in
    I want to be able to search a product with a keyword

  Background: There are products in the shop
    Given There are multiple keyboards in the shop
    Given There are non keyboard products in the shop

  Scenario: I search for keyboards
    Given I am in the home page
    When I write "keyboard" in the seach bar
    And I click on the looking glass icon
    Then I should be able to see all products with "keyboard" in the name
    And There should be no products without "keyboard" in the name