require 'restaurant'

describe Restaurant do

  let(:test_file) { 'spec/fixtures/restaurants_test.txt' }
  let(:crescent) { Restaurant.new(:name => 'Crescent', :cuisine => 'paleo', :price => '321') }
  
  describe 'attributes' do
  
    it "allow reading and writing for :name" do
      subject.name = 'Burger Shack'
      expect(subject.name).to eq('Burger Shack')
    end

    it "allow reading and writing for :cuisine" do
      subject.cuisine = 'Greasy'
      expect(subject.cuisine).to eq('Greasy')
    end

    it "allow reading and writing for :price" do
      subject.price = '5.99'
      expect(subject.price).to eq('5.99')
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
        expect(subject.name).to eq('')
      end

      it 'sets a default of "unknown" for :cuisine' do
        expect(subject.cuisine).to eq('unknown')
      end

      it 'does not set a default for :price' do
        expect(subject.price).to be_nil
      end
    end
    
    context 'with custom options' do
      
      it 'allows setting the :name' do
        subject.name = 'Burger Shack'
        expect(subject.name).to eq('Burger Shack')
      end

      it 'allows setting the :cuisine' do
        subject.cuisine = 'Greasy'
        expect(subject.cuisine).to eq('Greasy')
      end

      it 'allows setting the :price' do
        subject.price = '5.99'
        expect(subject.price).to eq('5.99')
      end
    end

  end
  
  describe '#save' do
    
    it 'returns false if @@file is nil' do
      expect(Restaurant.file).to be_nil

      expect(subject.save).to be false
    end
    
    it 'returns false if not valid' do
      expect(Restaurant.file).to be_nil
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil

      expect(subject.save).to be false
    end
    
    it 'calls append on @@file if valid' do
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil

      expect(Restaurant.file).to receive(:append)
      Restaurant.file.append(self)
    end
    
  end
  
  describe '#valid?' do
    
    it 'returns false if name is nil' do
      subject.name = nil
      expect(subject.name).to be_nil
      expect(subject.valid?).to be false
    end

    it 'returns false if name is blank' do
      expect(subject.name).to eq('')
      expect(subject.valid?).to be false
    end

    it 'returns false if cuisine is nil' do
      subject.cuisine = nil
      expect(subject.cuisine).to be_nil
      expect(subject.valid?).to be false
    end

    it 'returns false if cuisine is blank' do
      subject.cuisine = ''
      expect(subject.cuisine).to eq('')
      expect(subject.valid?).to be false
    end
    
    it 'returns false if price is nil' do
      expect(subject.price).to be_nil
      expect(subject.valid?).to be false
    end

    it 'returns false if price is 0' do
      subject.price = 0
      expect(subject.valid?).to be false
    end
    
    it 'returns false if price is negative' do
      subject.price = -99
      expect(subject.valid?).to be false
    end

    it 'returns true if name, cuisine, price are present' do
      subject.name = 'Burger Shack'
      subject.cuisine = 'Greasy'
      subject.price = 5.99
      expect(subject.name).to eq('Burger Shack')
      expect(subject.cuisine).to eq('Greasy')
      expect(subject.price).to eq(5.99)
      expect(subject.valid?).to be true
    end
  end

end
