
When(/^I add a new \.md file to the news folder$/) do
  FileUtils.touch('public/press/17777_SteveJobsIsDead.md')
end

When(/^I add a new image to the file in the news\/image folder$/) do
  FileUtils.touch('public/press/img/SteveJobs.png')
  # require 'rmagick'
  # canvas = Magick::Image.new(200, 200,
  #               Magick::HatchFill.new('white','lightcyan2'))
  # canvas.write('public/press/img/SteveJobs.png')
  
  md_file = 'public/press/17777_SteveJobsIsDead.md'
  if File.exists?(md_file)
    File.open(md_file, 'w') do |file|
      file.write('## Header 4 Steve {#header_id_jobs}  ')
      file.write("\n![Imagen de Steve Jobs](/press/img/SteveJobs.png 'Hippie Programmer')")
    end
  end
end

When(/^I refresh \(reload\) the page\.$/) do
  visit current_path
end

Then(/^It should render on the page with images\.$/) do
  img_placement = page.find('#SteveJobsIsDead').find('img')[:title]
  expect(img_placement).to eq('Hippie Programmer')
end

When(/^I remove the files\.$/) do
  md_file = 'public/press/17777_SteveJobsIsDead.md'
  img_file = 'public/press/img/SteveJobs.png'
  text = ""
  [md_file, img_file].each do |file|
    if File.exists?(file)
      text << "** removing: #{file}\n"
      FileUtils.rm(file) #if File.exists?(file)
    end
  end
  puts "#{text}"
end

After do
  md_file = 'public/press/17777_SteveJobsIsDead.md'
  img_file = 'public/press/img/SteveJobs.png'
  text =""
  [md_file, img_file].each do |file|
    if File.exists?(file)
      text << "** removing: #{file}\n"
      FileUtils.rm(file) #if File.exists?(file)
    end
  end
  puts "#{text}"
end