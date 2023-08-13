# encoding: UTF-8

describe 'NumberHelper' do

  include NumberHelper
  
  describe '#number_to_currency' do
    
    context 'using default values' do
      
      it "correctly formats an integer" do
        integer = number_to_currency(2000)
        expect(integer).to eq('$2,000.00')
      end
      
      it "correctly formats a float" do
        float = number_to_currency(99.99)
        expect(float).to eq('$99.99')
      end

      it "correctly formats a string" do
        string = number_to_currency('22.33')
        expect(string).to eq('$22.33')
      end
      
      it "uses delimiters for very large numbers" do
        large = number_to_currency(1000000000000.99)
        expect(large).to eq('$1,000,000,000,000.99')
      end

      it "does not have delimiters for small numbers" do
        small = number_to_currency(0.99)
        expect(small).to eq('$0.99')
      end

    end
    
    context 'using custom options' do
      
      it 'allows changing the :unit' do
        unit = number_to_currency(2000, unit: '%')
        expect(unit).to eq('%2,000.00')
      end

      it 'allows changing the :precision' do
        precision = number_to_currency(100.987654321, precision: 9)
        expect(precision).to eq('$100.987654321')
      end
      
      it 'omits the separator if :precision is 0' do
        omit = number_to_currency(1000, precision: 0)
        expect(omit).to eq('$1,000')
      end
      
      it 'allows changing the :delimiter' do
        change_delimiter = number_to_currency(9999.99, delimiter: '*')
        expect(change_delimiter).to eq('$9*999.99')
      end
      
      it 'allows changing the :separator' do
        change_separator = number_to_currency(9999.99, separator: '*')
        expect(change_separator).to eq('$9,999*99')
      end
            
      it 'correctly formats using multiple options' do
        change_all = number_to_currency(1000000000.9876543, unit: '%', precision: 7, delimiter: '*', separator: '&')
        expect(change_all).to eq('%1*000*000*000&9876543')
      end
      
    end
    
  end
  
end
