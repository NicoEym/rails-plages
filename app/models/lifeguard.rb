class Lifeguard < ApplicationRecord
  belongs_to :user
  belongs_to :season
  has_many :team_lifeguards, dependent: :destroy
  has_many :teams, through: :team_lifeguards
  has_many :availabilities, dependent: :destroy
  accepts_nested_attributes_for :availabilities, allow_destroy: true, reject_if: proc { |attributes| attributes['available'].blank? }


  def name
    user.full_name
  end

  def self.head_lifeguards_all
    where(validated_by_admin: true, head: true)
  end

  def self.arm_lifeguards_all
    where(validated_by_admin: true, head: false)
  end

  def self.available_on_that_date(date)
    joins(:availabilities).where(availabilities: {calendar: date, available: true})
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
