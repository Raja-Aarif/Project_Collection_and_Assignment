Feature: New functionalities
  
     Background: Admin login
       
      Given a user
      | Name         | User1Account        |
      | Email        | ak1@tamu.edu    |
      | Password     | password            |
      | UIN          | 111111111|
      Given an admin
      | Name         | AdminAccount        |
      | Email        | akapale@tamu.edu    |
      | Password     | password            |
      #7 users

      Given a user
      | Name         | User2Account        |
      | Email        | ak2@tamu.edu    |
      | Password     | password            |
      | UIN          | 111111112|
      
      And I am logged in as:
      | Email        | akapale@tamu.edu    |
      | Password     | password            |
      Then I should be on AdminAccount's user details page
      Given there exists a project
      |Title|ProjectA|
      | Semester|Fall|
      | Year|2018|
      Given there exists a team
      |Name|Navi|
      |User|User1Account|

    Scenario: See Team Preferences
    Given I am on home_page
    When I click "All Teams"
    Then I should be on teams_page
    And I should see "All Teams"
    And I should see "Team Name"
    And I should see "No. of Students"
    And I should see "Project Preferences"
    And I should see "Navi"
    When I click "Click here for Preferences"
    Then I should see "Positive Preference Projects"
    And I should see "Neutral Preference Projects"
    And I should see "Negative Preference Projects"
    
    
    Scenario: Flush previous teams info
    Given I am on home_page
    When I click "All Projects"
    Then I should see "All Projects"
    And  I should see "Erase previously assigned team info"



    
    
    