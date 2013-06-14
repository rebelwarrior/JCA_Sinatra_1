Feature: Allow pages to be requested in text.

Scenario: When I request a list of available files 'press' should be present.
  Given I am on "/es/home.txt"
  And I should get a return code of "200"
  When I go to "/es/help.txt"
  Then I should see "Opciones Disponibles"
  And I should see "press"
  And I should get a return code of "202"
  
Scenario: When I request press it should return the news
  Given I am on "/es/home.txt"
  When I go to "/es/press.txt"
  Then I should see "Comunicaciones"

Scenario: Text requests should be sanitized
  Given I go to "/es/help.txt"
  When I got to "blahkilltables?=;killtables;.txt"
  Then I should get a return code of "404"
  And The path should be only characters.

Scenario: All the options listed should be valid 'links'
  Given I go to "/es/help.txt"
  And I should get a return code of "202"
  When I follow all the options.
  Then I should get a return code of "200"
  
