class AddTweets < ActiveRecord::Migration
  def up
    Tweet.create(celebrity_id: 1, tweet: "live your dream. be creative")
    Tweet.create(celebrity_id: 2, tweet: "Happy Bday D.wade")
    Tweet.create(celebrity_id: 3, tweet: "Legiondary.")
  end

  def down
    Tweet.delete_all
  end

end