class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :score, :answers, :password_confirmation
  has_secure_password
  has_many :answers

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, :presence => true, :format => {:with => /[a-z]/i, :message => "must only have letters"}, :length => { :minimum => 2, :message => "must have at least 2 characters" } 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, :format => {:with => VALID_EMAIL_REGEX},
  :uniqueness => true

  VALID_PASSWORD_REGEX = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/
  validates :password, :presence => true, :format => {:with => VALID_PASSWORD_REGEX, :message => "must include at least one upper case letter, one lower case letter, and one numeric digit"},:length =>{:within => 8..16,:message => "must be between 8 to 16 characters"}
  validates :password_confirmation, :presence => true
  after_validation { self.errors.messages.delete(:password_digest)}

  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
