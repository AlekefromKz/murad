Feature: Taxi booking
  As a user
  Such that I create an account
  I want to request a loann

  Scenario: Create users
    Given the following users are existing
          | full_name| email	            | monthly_income   |
          | Murka | murad@murad.murad       | 2500             |
          | Almeke  | almaz@almaz.almaz     | 2700             |
    
    And I want to go to the user create page
    And I enter the data
    When I summit the booking request
    Then I should receive a confirmation message
