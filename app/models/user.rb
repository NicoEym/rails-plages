class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teams, through: :team_lifeguards

  def full_name
    "#{firstname} #{lastname}"
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
