class User < ActiveRecord::Base

  has_secure_password
  
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user = where('LOWER(email) = ?', email.downcase.delete(' '))[0]
    user && user.authenticate(password)
  end

end
