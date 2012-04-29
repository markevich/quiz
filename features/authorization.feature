Feature: Authorization for users
  In order to have an ability to safely work in my own sandbox
  As a user
  I want to authorize, using my login and password

  Scenario Outline: Authorization by login and password
    Given I open page "/"
    When i fill "<login>" in field "user[login]"
    When i fill "<password>" in field "user[password]"
    Then page should have content "<login>"

    Examples:
      | login  | password  |
      | valera | iamvalera |   
      | evil   | ragnarok  |  
      | enod   | enod1234  |    