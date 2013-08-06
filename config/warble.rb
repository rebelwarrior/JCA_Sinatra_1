Warbler::Config.new do |config|
  config.dirs << "bin"
  config.includes = FileList["Rakefile"]
  config.jar_name = "jca_portal"
  config.dirs << "db"
  config.excludes = FileList["**/*/*.box"]
  config.bundle_without = []
end