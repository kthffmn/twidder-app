class Celebrity < ActiveRecord::Base
  attr_accessible :handle, :name, :tweets, :answers
  has_many :tweets
  has_many :answers, through: :tweets

  #Scraper.new.add_to_database
end