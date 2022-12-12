Feature: Request loan
  As a user
  Such that I create an account
  I want to request a loan

  Scenario: Request loan success
    Given the following users are existing
          | full_name| email                   | monthly_income   |
          | Murka    | murad@murad.murad       | 2500             |
          | Almeke   | almaz@almaz.almaz       | 2700             |
    
    And I want to go to the loan request page
    And I want to request loan for "almaz@almaz.almaz" of "1500" euro for "3" years
    When I submit the loan request
    Then I should receive a confirmation message
