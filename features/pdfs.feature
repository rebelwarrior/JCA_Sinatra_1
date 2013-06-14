Feature: Displays PDFS
  As pdfs are added to folder you can access them properly. (Eventually add db integration.)

Scenario: Add a new folder year to Env. Reports Dias page.
  Given I visit rack page for "dias_all"
  And I should not see "1999party" 
  # And show me the page
  And I should see "Parent Directory" within ".yielded"
  When I add a new directory (new year) to the dias directory
  Then I should see "1999party" 
  And Then remove such directory.