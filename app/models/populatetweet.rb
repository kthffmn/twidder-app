class Populatetweet 
  attr_reader :client, :celebrity

  def initialize(celebrity)
    @celebrity = celebrity
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'kA7yw9y4aqFEM15GIXLbw'
      config.consumer_secret     = 'TQk5mpu2kQXz3jElUUfAERaEKkQS4m46GhqWoJ6OJA'
      config.access_token        = '2291303990-oi08n4H2NPbXvPA8NfHV4NeaRWLRbP4Xi1HnQlY'
      config.access_token_secret = '2GzX9E2p92hevEGBnjoEANw0Tp8gxcohdRQSSvOCtejas'
    end
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield max_id
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def get_all_objects
    collect_with_max_id do |max_id|
      options = {:count => 200, :include_rts => false}
      options[:max_id] = max_id unless max_id.nil?
      @client.user_timeline(celebrity.handle, options)
    end
  end

  def rm_hashtags(tweet)
    tweet.gsub(/#\S*/, "")
    # This tweet #has a hashtag. => "This tweet  a hashtag."
  end

  def rm_weird_characters(tweet)
    tweet.gsub(/[^\w.;?!,' -]/, "")
    # "This tweet has a ♥ that's a heart."=> "This tweet has a  that's a heart."
  end

  def rm_url_tweets(tweet)
    new_tweet = tweet.gsub(/.*http:\/\/.*/, "")
    new_tweet.gsub(/.*https:\/\/.*/, "")
    # "This tweet has a link and it is this http://www.twitter.com." => ""
    # "This tweet has a link and it is this https://www.twitter.com." => ""
  end

  def rm_at_tweets(tweet)
    tweet.gsub(/.*@.*/, "")
    # "This tweet has an @ sign." => ""
  end

  def rm_rt_tweets(tweet)
    tweet.gsub(/.*rt.*/i, "")
    # "This is a rt of a different user." => ""
    # "This is a RT of a different user." => ""
  end

  def rm_word_tweet(tweet)
    tweet.gsub(/tweet\S*/i, "")
  end 

  def misspelling?(tweet)
    Gingerice::Parser.new.parse(tweet)["result"]
  end

  def curse_word?(tweet)
    Swearjar.default.profane?(tweet)
  end 

  def select_misspelled_objects
    hash = {}
    get_all_objects.each do |object|
      text = rm_weird_characters(rm_hashtags(rm_word_tweet(rm_url_tweets(rm_at_tweets(rm_rt_tweets(object.text))))))
      answer = misspelling?(text)
      if text.downcase != answer.downcase && curse_word?(object.text) == false 
        hash[object] = answer
      end
    end
    hash
  end

  def add_to_database
    select_misspelled_objects.each do |object, answer|
      Tweet.create(
        :celebrity_id => celebrity.id, 
        :tweet => object.text,
        :answer => answer,
        :url => object.uri.to_s 
      )
    end
  end

end
