Feature: Switch Languages
  As a user of the website I want to be able to switch languages (english and spanish).

Scenario: Root Defaults to Spanish
  Given My browser is set Any Language.
  When I got to "root"
  Then It defaults to Spanish
  And I should be on "es/home"
  And sets the @lang variable to "es"
  
Scenario: Spanish links work
  Given I am on "es/home"
  When I follow "contáctenos" within ".footer"  
  And I should see "Contáctenos:" within ".yielded"
  

@javascript
Scenario: Switch to English Language
  Given I am on "es/home"
  And I should see "Servicios en Línea" within "#prTopBanner"
  When I press "English" within ".footer"
  Then The page redraws in English 
  And I should see "Online Services" within "#prTopBanner"
  And sets the @lang variable to "en"
  And The html lang attribute is not "es"
  


  