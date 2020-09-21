class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  # has_secure_password

  validates :name,  presence: { message: "введите имя" },
                    length: { maximum: 25, message: "макс. длина имени 25 символов" }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: { message: "введите email" }, 
                    format: { with: VALID_EMAIL_REGEX, message: "введите email правильного формата" },
                    uniqueness: { case_sensitive: false, message: "данная почта уже занята" }

  validates :password, length: { minimum: 6, message: "минимальная длина пароля 6 символов" }


  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end


  def User.encrypt(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end


  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end