class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :login, :password_digest
  validates_uniqueness_of :login

end
