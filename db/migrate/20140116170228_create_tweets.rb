class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :celebrity_id
      t.text :tweet
      t.text :answer
      t.text :url

      t.timestamps
    end
  end
end
