class Tweet < ActiveRecord::Base
  attr_accessible :answer, :celebrity_id, :tweet, :celebrity, :answers, :url, :populatetweet
  belongs_to :celebrity
  has_many :answers

	# Celebrity.all.each do |celebrity|
	# 	PopulateTweet.new(celebrity).add_to_database
	# end 
end

