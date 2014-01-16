class Answer < ActiveRecord::Base
  attr_accessible :correct, :guess, :tweet_id, :user_id
  belongs_to :user
  belongs_to :tweet
end
