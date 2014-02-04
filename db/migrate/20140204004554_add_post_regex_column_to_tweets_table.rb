class AddPostRegexColumnToTweetsTable < ActiveRecord::Migration
  def up
    add_column :tweets, :post_regex, :string 
  end

  def down 
    remove_column :tweets, :post_regex
  end 
end
