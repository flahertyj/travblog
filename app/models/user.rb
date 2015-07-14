require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_secure_password

  def password
    @password ||= Password.new(self.password_digest)
    @password
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
