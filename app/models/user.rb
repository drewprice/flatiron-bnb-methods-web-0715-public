class User < ActiveRecord::Base
  # shared
  has_many :reservations, through: :listings

  # guest
  has_many :trips,        foreign_key: 'guest_id', class_name: 'Reservation'
  has_many :reviews,      foreign_key: 'guest_id'
  has_many :hosts,        through: :trips

  # host
  has_many :listings,     foreign_key: 'host_id'
  has_many :guests,       through: :reservations
  has_many :host_reviews, through: :listings,       source: :reviews

  def status
    reload.host = listings.present?
    save
  end
end
