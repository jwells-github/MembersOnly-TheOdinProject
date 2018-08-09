class User < ApplicationRecord
  attr_accessor :remember_token
  
  # convert the email to lowercase to ensure that all emails are unique
  before_save { email.downcase! }
  
  # Check that a name was provided and that it isn't too long
  validates :name,  presence: true, length: { maximum: 50 }
  
  # check that an email was entered, that it follows a common email format
  # and that it isn't too long
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
    # converts a given password to bcrypt, and authenticates passwords against the saved bcrypt
    # Allows for passwords to be saved securely.
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    Brypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
end
