class GuessValidator < ActiveModel::Validator
  def validate(my_answer)
    my_tweet = Tweet.find(my_answer.tweet_id)
    if my_answer.guess.split(" ").length != my_tweet.tweet.split(" ").length
      my_answer.errors[:base] << "Your guess must have the same number of words as the tweet."
    end
  end
end

class Answer < ActiveRecord::Base
  attr_accessible :correct, :guess, :tweet_id, :user_id, :user, :tweet
  belongs_to :user
  belongs_to :tweet
  validates_with GuessValidator
  
  def rm_word_tweet(text)
    text.gsub(/tweet\S*/i, "")
    # "This is a tweet." => "This is a "
  end 

  def rm_hashtags(text)
    text.gsub(/#\S*/, "")
    # This guess #has a hashtag. => "This guess  a hashtag."
  end

  def rm_weird_characters(text)
    text.gsub(/[^\w.;?!,' -]/, "")
    # "This guess has a ♥ that's a heart."=> "This guess has a  that's a heart."
  end
  
  def apply_regex(string)
    rm_weird_characters(rm_hashtags(rm_word_tweet(string)))
  end
end


