class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teams, through: :team_lifeguards

  def full_name
    "#{firstname} #{lastname}"
  end

  def avatar
    if avatar_url.nil?
      "https://images.pexels.com/photos/356079/pexels-photo-356079.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
    else
      avatar_url
    end
  end

  def head?
    head == true
  end

  def admin?
    admin == true
  end

  def self.head_lifeguard
    where(head: true)
  end

  def self.arm_lifeguard
    where(head: false)
  end

  def rank
    head == true ? "Chef de poste" : "Equipier"
  end
end
