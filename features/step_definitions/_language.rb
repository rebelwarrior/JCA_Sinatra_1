require 'rspec/expectations'
require 'i18n' #internationalization (i18n)

Given /^My current language is Spanish\.$/ do
  I18n.locale = 'es'
  @lang = 'es'
end

When /^I click on the English button$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^The page redraws in English$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^sets the @lang variable to "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^My browser is set Any Language$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I load the page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^It is in Spanish$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the @lang variable is set to 'es'$/ do
  pending # express the regexp above with the code you wish you had
end

