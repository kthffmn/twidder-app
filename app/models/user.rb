class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :score
  has_many :answers
  validates :name, :length => { :minimum => 2, :message => "must have at least 2 characters" }
  validates :email, :uniqueness => true, :presence => true
  validates :name, :format => { :with => /[a-z]/i, :message => "only letters allowed"}
end
