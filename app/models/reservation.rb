class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, class_name: 'User'

  has_one :review
  has_one :host, through: :listing, class_name: 'User'

  validates :checkin, :checkout, presence: true
  validate  :guest_cannot_be_listing_host, :listing_must_be_available,
            :checkout_cannot_precede_checkin, :checkout_cannot_equal_checkin

  def conflict?(start, stop)
    start.between?(checkin, checkout) || stop.between?(checkin, checkout)
  end

  def duration
    checkout - checkin
  end

  def total_price
    listing.price * duration
  end

  def accepted?
    status == 'accepted'
  end

  def complete?
    checkout.past?
  end

  private

  def guest_cannot_be_listing_host
    if guest == listing.host
      errors.add(:guest, "can't also be the listing's host")
    end
  end

  def checkout_cannot_precede_checkin
    return if checkin.nil? || checkout.nil?

    errors.add(:checkout, 'cannot precede check-in date') if checkin > checkout
  end

  def checkout_cannot_equal_checkin
    return if checkin.nil? || checkout.nil?

    if checkin == checkout
      errors.add(:checkout, 'cannot be the same as check-in date')
    end
  end

  def listing_must_be_available
    return if checkin.nil? || checkout.nil?

    if listing.reservation_conflicts?(checkin, checkout)
      errors.add(:listing, 'is not available')
    end
  end
end
