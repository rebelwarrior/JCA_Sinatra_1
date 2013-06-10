# require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
Given(/^My current language is Spanish\.$/) do
  # pending # express the regexp above with the code you wish you had
  @lang = 'es'
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
  expect(@lang).to eq(language_set)
end

Given(/^My browser is set Any Language\.$/) do
  #need to stub the Rack I18n locale.
  I18n.locale = "pirate"
end

Then(/^It defaults to Spanish$/) do
  puts "@lang is #{@lang}"
  current_path = URI.parse(current_url).path
  expect(current_path.split('/')[1]).to eq('es')
end

# Then(/^the @lang variable is set to 'es'$/) do
#   expect(@lang).to eq('es')
# end #Why didn't this work?