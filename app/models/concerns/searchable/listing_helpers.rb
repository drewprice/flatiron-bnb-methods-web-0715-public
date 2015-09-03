module Searchable
  module ListingHelpers
    def reservations_per_listing
      if listings.empty?
        return 0
      else
        reservation_count / listings.count
      end
    end

    def reservation_count
      listings.reduce(0) { |count, listing| count + listing.reservation_count }
    end

    def openings(start, stop)
      start = start.to_date
      stop  = stop.to_date

      listings.reject { |listing| listing.reservation_conflicts?(start, stop) }
    end
  end
end
