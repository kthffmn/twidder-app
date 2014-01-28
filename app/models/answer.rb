class Answer < ActiveRecord::Base
  attr_accessible :correct, :guess, :tweet_id, :user_id, :user, :tweet
  belongs_to :user
  belongs_to :tweet

	validates :guess, :presence => true, :length => { :maximum => 200, :message => "must be between 1 and 200 characters"}

  def rm_hashtags(text)
    text.gsub(/#\S*/, "")
    # This guess #has a hashtag. => "This guess  a hashtag."
  end

  def rm_weird_characters(text)
    text.gsub(/[^\w.;?!,' -]/, "")
    # "This guess has a ♥ that's a heart."=> "This guess has a  that's a heart."
  end

  def rm_url_guess(text)
    new_guess = text.gsub(/.*http:\/\/.*/, "")
    new_guess.gsub(/.*https:\/\/.*/, "")
    # "This guess has a link and it is this http://www.twitter.com." => ""
    # "This guess has a link and it is this https://www.twitter.com." => ""
  end

  def rm_at_guess(text)
    text.gsub(/.*@.*/, "")
    # "This guess has an @ sign." => ""
  end

  def rm_rt_guess(text)
    text.gsub(/.*rt.*/i, "")
    # "This is a rt of a different user." => ""
    # "This is a RT of a different user." => ""
  end

  def rm_word_tweet(text)
    text.gsub(/tweet\S*/i, "")
  end 
  
  def apply_regex(string)
    rm_weird_characters(rm_hashtags(rm_word_tweet(rm_url_guess(rm_at_guess(rm_rt_guess(string))))))   
  end

end
