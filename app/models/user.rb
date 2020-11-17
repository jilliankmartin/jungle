class User < ActiveRecord::Base

  has_secure_password
  
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

end
