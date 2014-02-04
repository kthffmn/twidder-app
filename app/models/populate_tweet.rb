class PopulateTweet 
  attr_reader :client, :celebrity, :speller
  attr_accessor :text

  def initialize(celebrity)
    @speller = FFI::Aspell::Speller.new('en_US')
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
      puts celebrity.handle, max_id
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
    # "This has the word tweet in it." => "This has the word  in it."
  end 

  def rm_u_word(tweet)
    regex = /\bu\b/i
    if regex.match(tweet) != nil
      tweet = ""
    end 
    tweet
  # "This guess has an u instead of a you." => ""
  end

  def rm_elipses(tweet)
    tweet.gsub(/[^\w\s]/, " ")
  end 

  def misspelling?(tweet)
    Gingerice::Parser.new.parse(tweet)["result"]
  end

  def curse_word?(tweet)
    Swearjar.default.profane?(tweet)
  end 

  def apply_aspell(string)              # I love u.
    array = string.split(" ")           # ["I", "love", "u"]
    new_array = []
    array.each do |word|
      arr = @speller.suggestions(word)  # arr = [] arr = ["you", "your", "urn"]
      if arr.length > 0                 # arr.length = 0
        new_array << arr
      else
        new_array << [word]             # word => "I"  new_array = [["I"], ["love"], ["you", "your", "urn"], ["too"]]
      end
    end
    new_array     
  end

  def store?(string, new_array)
    store = false
    regex = string.gsub(/[^\w ']/, "")  
    array = regex.split(" ")            # ["I", "love", "u", "too"]
    index = 0
    array.each do |word|
      if new_array[index].include?(word) == false
        store = true
        break
      end
      index += 1
    end
    store
  end

  def remove_numbers(string)
    string.gsub(/(\d)/,"")
  end

  def select_misspelled_objects
    hash = {}
    index = 0 
    get_all_objects.each do |object|
      puts index
      index += 1
      # number_text = rm_weird_characters(rm_elipses(rm_hashtags(rm_word_tweet(rm_url_tweets(rm_at_tweets(rm_rt_tweets(object.text)))))))
      number_text = rm_weird_characters(rm_elipses(rm_u_word(rm_hashtags(rm_word_tweet(rm_url_tweets(rm_at_tweets(rm_rt_tweets(object.text))))))))
      text = remove_numbers(number_text)
      answer = apply_aspell(text)
      if store?(text, answer) && !curse_word?(object.text)
        hash[object] = [answer, text]
      end
    end 
    hash
  end 

  def add_to_database
    select_misspelled_objects.each do |object, answer_and_text|
      Tweet.create(
        :celebrity_id => celebrity.id, 
        :tweet => object.text,
        :answer => answer_and_text[0],
        :url => object.uri.to_s,
        :post_regex => answer_and_text[1]
      )
    end
  end

end
