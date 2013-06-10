Feature: Switch Languages
  As a user of the website I want to be able to switch languages (english and spanish).

@javascript
Scenario: Switch to English Language
  Given My current language is Spanish.
  And I am on "es/home"
  When I follow "contáctenos" within ".footer"
  And I press "English" within ".footer"
  Then The page redraws in English 
  And sets the @lang variable to "en"
  And I should see "Online Services" within "#prTopBanner"
  
Scenario: Defaults to Spanish
  Given My browser is set Any Language.
  When I got to "root"
  Then It defaults to Spanish
  And I should be on "es/home"
  And sets the @lang variable to "es"
  
  