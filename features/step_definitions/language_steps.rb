# require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
Given(/^My current language is Spanish\.$/) do
  # pending # express the regexp above with the code you wish you had
  I18n.locale = 'es'
end

Given(/^I am at "(.*?)"$/) do |page_name|
  visit path_to(page_name)
end

When(/^I got to "(.*?)"$/) do |page_name|
  visit path_to(page_name)
end

Then(/^The page redraws in English$/) do
  current_path = URI.parse(current_url).path
  expect(current_path.split('/')[1]).to eq('en')
end

Then(/^sets the @lang variable to "(.*?)"$/) do |language_set|
  # I suspect this can't be checked easily since the @lang variable is internal not part of the render
  #expect(@lang).to eq(language_set)
  #Use Capybara DSL to check this:
  # page.has_xpath?('.//html[@lang="#{language_set}"]')
  #Checking this via the html lang attribute which is set to @lang since I can't reach @lang
  html_lang = page.find('html')[:lang]
  # puts html_lang
  expect(html_lang).to eq(language_set)
end

Then(/^The html lang attribute is not "(.*?)"$/) do |language_set|
  page.has_no_xpath?('.//html[@lang="#{language_set}"]')
end

Given(/^My browser is set Any Language\.$/) do
  #need to stub the Rack I18n locale.
  I18n.locale = "pirate"
end

Then(/^It defaults to Spanish$/) do
  #checks path
  current_path = URI.parse(current_url).path
  expect(current_path.split('/')[1]).to eq('es')
end

# Then(/^the @lang variable is set to 'es'$/) do
#   expect(@lang).to eq('es')
# end #Why didn't this work?