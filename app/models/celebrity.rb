class Celebrity < ActiveRecord::Base
  attr_accessible :handle, :name
  has_many :tweets
  has_many :answers, through: :tweets
end