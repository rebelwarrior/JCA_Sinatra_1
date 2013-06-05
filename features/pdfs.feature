Feature: Displays PDFS
  As pdfs are added to folder you can access them properly. (Eventually add db integration.)
  
Scenario: Add a new folder (year) to Env. Reports (Dias) page.
  Given I am on dias_all
  When I add a new directory (new year) to the dias directory
  Then I see such directory displayed.
