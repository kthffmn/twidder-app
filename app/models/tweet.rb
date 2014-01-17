class Tweet < ActiveRecord::Base
  attr_accessible :answer, :celebrity_id, :tweet, :celebrity, :answers
  belongs_to :celebrity
  has_many :answers
end
