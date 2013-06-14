When(/^I follow all the options.$/) do
  puts "Visiting: "
  page.source.each_line do |line|
    if line.match(/^\s+\d+\.\s(\w+)\.\w{2,3}$/)
      puts " ---> #{$1}.txt"
      visit path_to("/#{$1}.txt")
      expect(page.status_code).to eq(200)
    end
  end
end

Then(/^I should get a return code of "(.*?)"$/) do |number|
  expect(page.status_code).to eq(number.to_i)
end

Then(/^I should not get a return code of "(.*?)"$/) do |number|
  expect(page.status_code).not_to eq(number.to_i)
end

Then(/^The path should be only characters\.$/) do
  # pending # express the regexp above with the code you wish you had
  puts "Sanitized path: #{page.current_path}"
  expect(page.current_path).to match(/\w+/) 
end