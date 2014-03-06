class Celebrity < ActiveRecord::Base
  attr_accessible :handle, :name, :tweets, :answers
  has_many :tweets
  has_many :answers, through: :tweets

  def self.populate
    Scraper.new.add_to_database
  end

  def self.add_twidder
    Celebrity.create(:name => 'Twidder', :handle => 'twidder_app')
  end

  def self.add_celebs
    Celebrity.create(:name => "Lil Scrappy Merlo", :handle => "reallilscrappy")
    Celebrity.create(:name => "Snoop Lion", :handle => "snooplion")
    Celebrity.create(:name => "Bruno Mars", :handle => "brunomars")
    Celebrity.create(:name => "Kendall Jenner", :handle => "KendallJenner")
    Celebrity.create(:name => "Lisa Raye", :handle => "TheRealLRaye1")
    Celebrity.create(:name => "Wiz Khalifa", :handle => "wizkhalifa")
    Celebrity.create(:name => "Ryan Lochte", :handle => "RyanLochte")
    Celebrity.create(:name => "Shaquille O'Neal", :handle => "SHAQ")
    Celebrity.create(:name => "Jim Jones", :handle => "jimjonescapo")
  end

end