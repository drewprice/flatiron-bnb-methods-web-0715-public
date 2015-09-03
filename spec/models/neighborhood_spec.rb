describe Neighborhood do
  describe 'associations' do
    it 'has a name' do
      expect(@nabe3.name).to eq('Brighton Beach')
    end

    it 'belongs to a city' do
      expect(@nabe3.city.name).to eq('NYC')
    end

    it 'has many listings' do
      expect(@nabe3.listings).to include(@listing3)
    end
  end

  describe 'instance methods' do
    it 'knows about all the available listings given a date range' do
      expect(@nabe1.openings('2014-05-01', '2014-05-30')).to include(@listing1)
    end
  end

  describe 'class methods' do
    describe '.max_by_reservations_per_listing' do
      it 'knows the neighborhood with the highest ratio of reservations to listings' do
        expect(Neighborhood.max_by_reservations_per_listing).to eq(@nabe1)
      end
      it "doesn't hardcode the neighborhood with the highest ratio" do
        make_denver
        expect(Neighborhood.max_by_reservations).to eq(Neighborhood.find_by(name: 'Lakewood'))
      end
    end

    describe '.max_by_reservations' do
      it 'knows the neighborhood with the most reservations' do
        expect(Neighborhood.max_by_reservations).to eq(@nabe1)
      end
      it "doesn't hardcode the neighborhood with the most reservations" do
        make_denver
        expect(Neighborhood.max_by_reservations).to eq(Neighborhood.find_by(name: 'Lakewood'))
      end
    end
  end
end
