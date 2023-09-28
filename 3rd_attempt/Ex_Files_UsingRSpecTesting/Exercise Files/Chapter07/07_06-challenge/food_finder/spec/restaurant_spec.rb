require 'restaurant'
require 'pry-byebug'

describe Restaurant do

  let(:test_file) { 'spec/fixtures/restaurants_test.txt' }
  let(:crescent) { Restaurant.new(:name => 'Crescent', :cuisine => 'paleo', :price => '321') }
  
  describe 'attributes' do
  
    it "allow reading and writing for :name" do
      expect(crescent.name).to eq('Crescent')
      crescent.name = 'Burger Shack'
      expect(crescent.name).to eq('Burger Shack')
    end

    it "allow reading and writing for :cuisine" do
      expect(crescent.cuisine).to eq('paleo')
      crescent.cuisine = 'greasy'
      expect(crescent.cuisine).to eq('greasy')
    end

    it "allow reading and writing for :price" do
      expect(crescent.price).to eq('321')
      crescent.price = '9.99'
      expect(crescent.price).to eq('9.99')
    end
    
  end
  
  describe '.load_file' do

    it 'does not set @@file if filepath is nil' do
      no_output { Restaurant.load_file(nil) }
      expect(Restaurant.file).to be_nil
    end
    
    it 'sets @@file if filepath is usable' do
      no_output { Restaurant.load_file(test_file) }
      expect(Restaurant.file).not_to be_nil
      expect(Restaurant.file.class).to be(RestaurantFile)
      expect(Restaurant.file).to be_usable
    end

    it 'outputs a message if filepath is not usable' do
      expect do
        Restaurant.load_file(nil)
      end.to output(/not usable/).to_stdout
    end
    
    it 'does not output a message if filepath is usable' do
      expect do
        Restaurant.load_file(test_file)
      end.not_to output.to_stdout
    end
    
  end
  
  describe '.all' do
    
    it 'returns array of restaurant objects from @@file' do
      # pending
      Restaurant.load_file(test_file)
      restaurants = Restaurant.all
      expect(restaurants.class).to eq(Array)
      expect(restaurants.length).to eq(6)
      expect(restaurants.first.class).to eq(Restaurant)
    end

    it 'returns an empty array when @@file is nil' do
      # pending
      no_output { Restaurant.load_file(nil) }
      restaurants = Restaurant.all
      expect(restaurants).to eq([])
    end
    
  end
  
  describe '#initialize' do

    context 'with no options' do
      # subject would return the same thing
      let(:no_options) { Restaurant.new }

      it 'sets a default of "" for :name' do
        expect(no_options.name).to eq('')
      end

      it 'sets a default of "unknown" for :cuisine' do
        expect(no_options.cuisine).to eq('unknown')
      end

      it 'does not set a default for :price' do
        expect(no_options.price).to be nil
      end
    end
    
    context 'with custom options' do

      let(:some_options) { Restaurant.new(name: 'Burger Shack', cuisine: 'greasy', price: 9.99) }
      
      it 'allows setting the :name' do
        expect(some_options.name).to eq('Burger Shack')
      end

      it 'allows setting the :cuisine' do
        expect(some_options.cuisine).to eq('greasy')
      end

      it 'allows setting the :price' do
        expect(some_options.price).to eq(9.99)
      end

    end

  end
  
  describe '#save' do
    
    it 'returns false if @@file is nil' do
      no_file = Restaurant.new
      expect(no_file.save).to be false
    end
    
    it 'returns false if not valid' do
      invalid_file = Restaurant.new
      allow(invalid_file).to receive(:valid?).and_return(false)
      expect(invalid_file.save).to be false
    end
    
    it 'calls append on @@file if valid' do
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil
      valid_file = Restaurant.new(name: 'Burger Shack', cuisine: 'greasy', price: 9.99)
      expect(Restaurant.file).to receive(:append).once
      valid_file.save
    end
    
  end
  
  describe '#valid?' do

    let(:burger_shack) { Restaurant.new }
    
    it 'returns false if name is nil' do
      burger_shack.name = nil
      expect(burger_shack.valid?).to be false
    end

    it 'returns false if name is blank' do
      burger_shack.name = '    '
      expect(burger_shack.valid?).to be false
    end

    it 'returns false if cuisine is nil' do
      burger_shack.cuisine = nil
      expect(burger_shack.valid?).to be false
    end

    it 'returns false if cuisine is blank' do
      burger_shack.cuisine = '     '
      expect(burger_shack.valid?).to be false
    end
    
    it 'returns false if price is nil' do
      burger_shack.price = nil
      expect(burger_shack.valid?).to be false
    end

    it 'returns false if price is 0' do
      burger_shack.price = 0
      expect(burger_shack.valid?).to be false
    end
    
    it 'returns false if price is negative' do
      burger_shack.price = -100
      expect(burger_shack.valid?).to be false
    end

    it 'returns true if name, cuisine, price are present' do
      burger_shack.name = 'Burger Shack'
      burger_shack.cuisine = 'greasy'
      burger_shack.price = 9.99
      expect(burger_shack.valid?).to be true
    end
  end

end
