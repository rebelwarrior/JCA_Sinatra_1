Feature: Allow pages to be requested in text.

Scenario: When I request a list of available files all should be available.
  Given I go to "/es/help.txt"
  When I follow all the options
  Then I should get a return code of "200"
  
Scenario: When I ask for a text link that doesn't exist it should give a redirect code.
  Given I am on "/es/home.txt"
  When I go to "/es/help.txt"
  Then I should see "Opciones Disponibles"
  And I should not get a return code of "200"