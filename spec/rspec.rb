require './app/main.rb'
require 'rspec'
require 'rack/test'

set :environment, :test

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe "JCA Sinatra Application" do
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  describe "It creates the PressPage" do
    it "reads all the markdown files from the public/press folder and passes them to the view"
    
  end
  
  describe "accesibility option" do
    it "delivers a text document when asked for a .txt extention" do 
    end
    
    it "displays a list of available files if a bad request is made w/ a .txt extention"
    
  end
  
  
end

