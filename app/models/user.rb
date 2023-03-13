class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 5 }, allow_blank: false
  validates :password_confirmation, presence: true

  before_save { |user| user.email = user.email.downcase }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
  
    if(user && user.authenticate(password))
      return user
    else
      return nil
    end
  end

end
