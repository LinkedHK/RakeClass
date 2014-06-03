class Status < ActiveRecord::Base

  validates_presence_of :content,:name

end
