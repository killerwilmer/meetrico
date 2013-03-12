class User < ActiveRecord::Base

  require Rails.root.join('lib', 'devise', 'encryptors', 'md5')
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :encryptable
  
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :bio, :avatar, :id
  
  validates :name, :presence => true
  
  has_many :reservations
  has_many :authentications
  has_many :coworking_spaces
  has_many :tickets

  self.per_page = 20
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    self.name = omniauth['user_info']['name'] if name.blank?
    self.avatar = omniauth['user_info']['image'] if avatar.blank?
    self.gender = omniauth['extra']['user_hash']['gender'] if gender.blank?
    
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def valid_password?(password)
    return false if encrypted_password.blank?
    Devise.secure_compare(Devise::Encryptors::Md5.digest(password), self.encrypted_password)
  end

  def password_salt=(password_salt)
  end

  def password_salt
    ''
  end

  def password_digest(password)
    
    self.class.encryptor_class.digest(password)
  end

end
