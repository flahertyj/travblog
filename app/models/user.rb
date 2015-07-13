require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_secure_password

  # validates :username, presence: true, uniqueness: true
  # validates :password_digest, presence: true

  def password
    puts "PASSWORD METHOD CALLED FROM USER MODEL"
    @password ||= Password.new(password_digest)
    puts "ENCRYPTED PASSWORD"
    p @password
  end

  def password=(new_password)
    puts "PASSWORD= METHOD CALLED FROM USER MODEL"
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    puts "USER DIGEST CALLED"
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
