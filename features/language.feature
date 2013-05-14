Feature: Switch Languages
  As a user of the website I want to be able to switch languages (english and spanish).
  
Scenario: Switch to English Language
  Given My current language is Spanish.
  When I click on the English button
  Then The page redraws in English 
  And sets the @lang variable to "en"
  
Scenario: Defaults to Spanish
  Given My browser is set Any Language
  When I load the page
  Then It's in Spanish
  And the @lang variable is set to 'es'
  
  