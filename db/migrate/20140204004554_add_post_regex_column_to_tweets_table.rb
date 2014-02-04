class AddPostRegexColumnToTweetsTable < ActiveRecord::Migration
  def up
    add_column :tweets, :post_regex, :string 
  end

  def drown 
    remove_column :tweets, :post_regex
  end 
end
