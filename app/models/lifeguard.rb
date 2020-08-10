class Lifeguard < ApplicationRecord
  belongs_to :user

  belongs_to :season
  has_many :team_lifeguards, dependent: :destroy
  has_many :teams, through: :team_lifeguards
  has_many :availabilities
  accepts_nested_attributes_for :availabilities, allow_destroy: true

  def head?
    head == true
  end

  def name
    user.full_name
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
