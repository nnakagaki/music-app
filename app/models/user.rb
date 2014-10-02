class User < ActiveRecord::Base
  after_initialize :set_session_token

  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6 }


  def self.find_by_credentials(user_params)
    user = User.find_by(email: user_params[:email])
    return nil unless user
    return user if user.is_password?(user_params[:password])

    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    @password = password
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(12)
    self.save!

    self.session_token
  end

  private
  def set_session_token
    self.session_token = SecureRandom.base64(12)
  end

end
