class Song < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :format
	validates_presence_of :length
	validates_presence_of :size
end
