class User < ActiveRecord::Base
 before_save { self.email = email.downcase }
 before_create :create_remember_token

 validates :name, presence: true, length: { minimum: 3,maximum: 50 }
 VALID_EMAIL_REGEX = /\A([a-z0-9_-]+\.)*[a-z0-9_-]+@[a-z0-9_-]+(\.[a-z0-9_-]+)*\.[a-z]{2,6}|z/i
 validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
 VALID_INCOME_REGEX = /\d+(\.\d{0,})?/
 validates :income, presence: true, format: { with: VALID_INCOME_REGEX }
 has_secure_password
 validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def add_percent(income)
    if income.to_f > 100000
	   self.percent = 0.5
	end   
    if income.to_f <= 100000
	   self.percent = 0.2
	end   
    if income.to_f <= 10000
	   self.percent = 0.1
	end   
    if income.to_f <= 1000
	   self.percent = 0.05
	end   
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
