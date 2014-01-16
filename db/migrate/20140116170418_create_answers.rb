class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :tweet_id
      t.string :guess
      t.boolean :correct

      t.timestamps
    end
  end
end
