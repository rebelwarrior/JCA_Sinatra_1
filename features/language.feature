Feature: Switch Languages
  As a user of the website I want to be able to switch languages (english and spanish).
  
Scenario: Switch to English Language
  Given My current language is Spanish.
  When I got to contact_us
  And I press the '#english' button
  Then The page redraws in English 
  And sets the @lang variable to "en"
  
Scenario: Defaults to Spanish
  Given My browser is set Any Language.
  When I got to root
  Then It defaults to english.
  And the @lang variable is set to 'es'
  
  