class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :celebrity_id
      t.string :tweet
      t.string :answer

      t.timestamps
    end
  end
end
