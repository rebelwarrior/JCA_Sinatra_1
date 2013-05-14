# models.rb


ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'db.sqlite3',
    host:     'localhost', )

class PDFResource < ActiveRecord::Base
  validates :url, :presence => true
  validates :url, :uniqueness => true
  validates :thumb_url, :uniqueness => true
end

class CalendarOfPublicHearings < ActiveRecord::Base
  
  
end