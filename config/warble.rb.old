Warbler::Config.new do |config|
  # config.features += ['executable']
  config.jar_name = "jca_#{Time.now.to_i}"
  config.dirs = %w(app config db lib tmp bin public views)
  config.excludes = FileList["**/*/*.box"]
  config.includes = FileList["Rakefile"]
  config.bundle_without = []
  config.webserver = 'jenkins-ci.winstone'
end