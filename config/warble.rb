Warbler::Config.new do |config|
  config.features += ['executable']
  config.dirs << "bin"
  config.includes = FileList["Rakefile"]
  config.jar_name = "jca"
  config.dirs << "db"
  config.dirs << "views"
  config.excludes = FileList["**/*/*.box"]
  config.bundle_without = []
end