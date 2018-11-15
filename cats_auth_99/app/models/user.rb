class User < ApplicationRecord
  validates :user_name, :password_digest, presence: true, uniqueness: true
  validates :session_token, uniqueness: true
  
  after_initialize do |user|
    self.session_token ||= User.generate_token
  end
  
  def self.generate_token
    SecureRandom.urlsafe_base64
  end
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    if user &&  is_password?(password)
      user
    else
      nil
    end
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    user = User.find_by(user_name: self.user_name)
    
    BCrypt::Password.new(user.password_digest) == password
  end
  
end