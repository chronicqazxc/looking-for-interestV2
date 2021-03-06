class User < ActiveRecord::Base
	before_save { self.session_token ||= Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)}
	has_secure_password
	validates :name, presence: true, length: { maximum: 30 }
	validates :email, format: { with: /\A[^@]+@[^@]+\z/}, uniqueness: {case_sensitive: false}
end
