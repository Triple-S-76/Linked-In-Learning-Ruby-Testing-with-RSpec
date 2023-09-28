# encoding: UTF-8

describe 'NumberHelper' do

  include NumberHelper
  
  describe '#number_to_currency' do
    
    context 'using default values' do
      
      it "correctly formats an integer" do
        my_integer = 123
        expect(number_to_currency(my_integer)).to eq('$123.00')
      end
      
      it "correctly formats a float" do
        my_float = 1.99
        expect(number_to_currency(my_float)).to eq('$1.99')
      end

      it "correctly formats a string" do
        my_string = '99.99'
        expect(number_to_currency(my_string)).to eq('$99.99')
      end
      
      it "uses delimiters for very large numbers" do
        large_number = 1234567.89
        expect(number_to_currency(large_number)).to eq('$1,234,567.89')
      end

      it "does not have delimiters for small numbers" do
        small_number = 19
        expect(number_to_currency(small_number)).to eq('$19.00')
      end
    end
    
    context 'using custom options' do
      
      it 'allows changing the :unit' do
        number = 123
        options = { unit: '%' }
        expect(number_to_currency(number, options)).to eq('%123.00')
      end

      it 'allows changing the :precision' do
        number = 123.456789
        options = { precision: 8}
        expect(number_to_currency(number, options)).to eq('$123.45678900')
      end
      
      it 'omits the separator if :precision is 0' do
        number = 123.99
        options = { precision: 0 }
        expect(number_to_currency(number, options)).to eq('$123')
      end
      
      it 'allows changing the :delimiter' do
        number = 1234567.89
        options = { delimiter: '^' }
        expect(number_to_currency(number, options)).to eq('$1^234^567.89')
      end
      
      it 'allows changing the :separator' do
        number = 9.99
        options = { separator: '*' }
        expect(number_to_currency(number, options)).to eq('$9*99')
      end
            
      it 'correctly formats using multiple options' do
        number = 1234567.89
        options = {
          unit: '%',
          precision: 6,
          delimiter: '^',
          separator: '*'
        }
        expect(number_to_currency(number, options)).to eq('%1^234^567*890000')
      end
      
    end
    
  end
  
end
