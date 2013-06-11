When(/^I add a new directory \(new year\) to the dias directory$/) do
  if FileUtils.pwd == (File.expand_path("~") + "/Code/JCA_1/JCA_Sinatra")
    FileUtils.mkdir("public/resources/pdfs/dias/1999party")
  elsif File.exits?("public/resources/pdfs/dias/") && File.directory?("public/resources/pdfs/dias/")
    puts "Creating Directory 1999party"
    FileUtils.mkdir("public/resources/pdfs/dias/1999party")
  else
    puts "Possibly in the wrong directory."
  end    
end

Then(/^Then remove such directory\.$/) do
  if File.exists?("public/resources/pdfs/dias/1999party") and File.directory?("public/resources/pdfs/dias/1999party")
    FileUtils.remove_dir("public/resources/pdfs/dias/1999party")
  else
    puts "Directory not found"
  end
end

Given(/^I visit rack page for "(.*?)"$/) do |arg1|
  # get('/pdfs/dias')
  visit path_to(arg1)
  expect(page.status_code).to eq(200)
  sleep 0.5
end