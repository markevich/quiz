class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :login, :password_digest
  validates :login,  presence: true,
                     uniqueness: true,
                     length: { within: 4..32 }

  validates :password,  presence: true,
                        length: { within: 5..64 },
                        on: :create

end
