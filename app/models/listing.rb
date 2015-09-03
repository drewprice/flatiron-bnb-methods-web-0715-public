class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, class_name: 'User'

  has_many :reservations
  has_many :reviews, through: :reservations
  has_many :guests, class_name: 'User', through: :reservations

  validates :address, :listing_type, :title, :description, :price, :neighborhood,
            presence: true

  after_create  :confirm_host
  after_destroy :confirm_host

  def reservation_conflicts?(start, stop)
    reservations.any? { |reservation| reservation.conflict?(start, stop) }
  end

  def reservation_count
    reservations.count
  end

  def average_rating
    reviews.average(:rating)
  end

  private

  def confirm_host
    host.status
  end
end
