When(/^I follow all the options$/) do
  page.source.each_line do |line|
    puts "---> #{line}"
  end
end

Then(/^I should get a return code of "(.*?)"$/) do |number|
  expect(page.status_code).to eq(number.to_i)
end


Then(/^I should not get a return code of "(.*?)"$/) do |number|
  expect(page.status_code).not_to eq(number.to_i)
end