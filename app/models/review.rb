class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, class_name: 'User'

  validates :rating, :description, :reservation, presence: true
  validate :reservation_must_be_authentic, :reservation_must_be_complete

  private

  def reservation_must_be_authentic
    return if reservation.nil?

    errors.add(:reservation, 'is not authentic') unless reservation.accepted?
  end

  def reservation_must_be_complete
    return if reservation.nil?

    errors.add(:reservation, 'is not yet complete') unless reservation.complete?
  end
end
