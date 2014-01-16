class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :score
  has_many :answers
end
