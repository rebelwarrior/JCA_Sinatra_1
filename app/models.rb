# models.rb
require 'active_record'
require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'db.sqlite3',
    host:     'localhost', )

class PDFResource < ActiveRecord::Base
  validates :url, :presence => true
  validates :url, :uniqueness => true
  validates :thumb_url, :uniqueness => true
end

