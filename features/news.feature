Feature: Populates News page
  As a maintainer of the news page I want to add a markdown file to a folder and the page to read it properly and insert it into the web page.
  
Scenario: A new .md file is added to the news folder.
  Given I am on "news"
  And I should see "Gerente de Comunicaciones y Educación Ambiental" within ".yielded"
  When I add a new .md file to the news folder
  And I add a new image to go along with the file in the news/image folder
  And I refresh (reload) the page.
  Then I should see "Header 4 Steve" within "#SteveJobsIsDead"
  And It should render on the page with images.
  And I should see "SteveJobsIsDead" within ".navbar-inner"
  When I remove the files.
  And I refresh (reload) the page.
  Then I should not see "SteveJobsIsDead" within ".navbar-inner"
  
  
  
