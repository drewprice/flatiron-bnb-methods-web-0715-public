module Searchable
  def max_by_reservations_per_listing
    all.max_by(&:reservations_per_listing)
  end

  def max_by_reservations
    all.max_by(&:reservation_count)
  end
end
