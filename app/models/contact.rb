class Contact < ActiveRecord::Base
  VALID_STATES = ["MA"]

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :state, presence: true,
    inclusion: {in: (VALID_STATES),
    message: "State must be real"}
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :notes, length: { maximum: 500,
    too_long: "Notes are too long (max 500 characters)" }

  def full_name
    [first_name, last_name].join(' ')
  end

  def location
    [city, state].join(', ')
  end

  def self.alphabetically
    order('LOWER(first_name) ASC')
  end
end
