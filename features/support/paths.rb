# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /root/
      '/'
    when /es\/home/
      '/es/home'
    when /contact_us/
      'contact_us'
    when /news/
      '/es/press'
    when /dias_all/
      # '/es/dias/all'
      '/pdfs/dias'
    when /es\/help.txt/
      '/es/help.txt'
    when /es\/press.txt/
      '/es/press.txt'
    when /(\w+|\S*)\.txt/
      "/es/#{$1}.txt"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
