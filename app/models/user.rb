class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :season
  has_many :team_lifeguards, dependent: :destroy
  has_many :teams, through: :team_lifeguards
  has_many :availabilities
  accepts_nested_attributes_for :availabilities, allow_destroy: true
  has_one_attached :photo

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

  def self.admins
    where(admin: true)
  end

  def rank
    head == true ? "Chef de poste" : "Equipier"
  end

  def bnssa?
    bnssa == true ? "Oui" : "Non"
  end

  def pse1?
    pse1 == true ? "Oui" : "Non"
  end

  def pse2?
    pse2 == true ? "Oui" : "Non"
  end

  def days_available
    availabilities.where(available: true)
  end
end
