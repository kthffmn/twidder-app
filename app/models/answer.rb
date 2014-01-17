class Answer < ActiveRecord::Base
  attr_accessible :correct, :guess, :tweet_id, :user_id
  belongs_to :user
  belongs_to :tweet

	validates :guess, :presence => true, :length => { :maximum => 200, :message => "must be between 1 and 200 characters"}
end
