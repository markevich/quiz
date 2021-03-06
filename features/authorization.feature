@authorization
Feature: Authorization for users
  In order to have an ability to safely work in my own sandbox
  As a user
  I want to authorize, using my login and password

  Background:
    Given the following user exists:
      | login  | password  |
      | valera | iamvalera |   
      | evil   | ragnarok  |  
      | enod   | enod1234  |  

  Scenario Outline: Authorization with existing login and password
    Given I open page "/"
    When i fill "<login>" in field "user[login]"
    When i fill "<password>" in field "user[password]"
    When i click button "#login_button"
    Then path should be "/quizzes"
    Then page should have content "<login>"

    Examples:
      | login  | password  |
      | valera | iamvalera |   
      | evil   | ragnarok  |  
      | enod   | enod1234  |    