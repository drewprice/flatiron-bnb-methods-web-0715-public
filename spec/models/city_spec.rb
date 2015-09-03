describe City do
  describe 'associations' do
    it 'has a name' do
      expect(City.first.name).to eq('NYC')
    end

    it 'has many neighborhoods' do
      expect(City.first.neighborhoods).to eq([@nabe1, @nabe2, @nabe3])
    end
  end

  describe 'instance methods' do
    it 'knows about all the available listings given a date range' do
      expect(City.first.openings('2014-05-01', '2014-05-05')).to eq([@listing2, @listing3])
    end
  end

  describe 'class methods' do
    describe '.max_by_reservations_per_listing' do
      it 'knows the city with the highest ratio of reservations to listings' do
        expect(City.max_by_reservations_per_listing).to eq(City.find_by(name: 'NYC'))
      end

      it "doesn't hardcode the city with the highest ratio of reservations to listings" do
        make_denver
        expect(City.max_by_reservations_per_listing).to eq(City.find_by(name: 'Denver'))
      end
    end

    describe '.max_by_reservations' do
      it 'knows the city with the most reservations' do
        expect(City.max_by_reservations).to eq(City.find_by(name: 'NYC'))
      end

      it 'knows the city with the most reservations' do
        make_denver
        expect(City.max_by_reservations).to eq(City.find_by(name: 'Denver'))
      end
    end
  end
end
