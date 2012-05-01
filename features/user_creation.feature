Feature: Authorization for users
  In order to use application
  As a user
  I want create account

  Scenario Outline: Registration with login and password
    Given I open page "/"
    Then I click link "#register"
    Then page should be "/user/new"
    When i fill "<login>" in field "user[login]"
    When i fill "<password>" in field "user[password]"
    When i fill "<password_confirmation>" in field "user[password_confirmation]"
    When i click button "#register_button"
    Then path should be "/quizzes"
    Then page should have content "<login>"

    Examples:
      | login  | password  | password_confirmation |
      | valera | iamvalera | iamvalera             |
      | evil   | ragnarok  | ragnarok              |
      | enod   | enod1234  | enod1234              |