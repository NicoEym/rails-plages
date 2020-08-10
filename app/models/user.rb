class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_one :lifeguard

  def full_name
    "#{firstname} #{lastname}"
  end

  def avatar
    if avatar_url.nil?
      "https://as1.ftcdn.net/jpg/02/33/46/24/500_F_233462402_Fx1yke4ng4GA8TJikJZoiATrkncvW6Ib.jpg"
    else
      avatar_url
    end
  end

  def admin?
    admin == true
  end

  def self.admins
    where(admin: true)
  end
end
