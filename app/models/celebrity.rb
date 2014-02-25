class Celebrity < ActiveRecord::Base
  attr_accessible :handle, :name, :tweets, :answers
  has_many :tweets
  has_many :answers, through: :tweets

  def populate
    Scraper.new.add_to_database
  end

  def add_twidder
    Celebrity.create(:name => Twidder, :handle => twidder_app)
  end 
end