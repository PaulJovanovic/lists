class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :likes
  has_many :list_items

  validates :username, :uniqueness => { :case_sensitive => false }

  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def admin?
    role == "admin"
  end

  def guest?
    role == "guest"
  end

  def user?
    role == "user"
  end

  def like(likable)
    if likes?(likable)
      true
    else
      likes.create(likable_type: likable.class.name, likable_id: likable.id)
    end
  end

  def unlike(likable)
    if !likes?(likable)
      true
    else
      likes.where(likable_type: likable.class.name, likable_id: likable.id).last.destroy
    end
  end

  def likes?(likable)
    likes.where(likable_type: likable.class.name, likable_id: likable.id).count > 0
  end

  def generate_api_token
    begin
      token = SecureRandom.urlsafe_base64
    end while self.class.exists?(api_token: token)
    update_column(:api_token, token) && token
  end
end
