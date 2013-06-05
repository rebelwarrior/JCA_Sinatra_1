Feature: Populates News page
  As a maintainer of the news page I want to add a markdown file to a folder and the page to read it properly and insert it into the web page.
  
Scenario: A new .md file is added to the news folder.
  Given I am on news
  When I Add a new .md file to the news folder
  And I add a new image to go along with the file in the news/image folder
  And I refresh (reload) the page.
  Then It renders at the top of the page with images.
  And List it in order on the sidebar.
  
