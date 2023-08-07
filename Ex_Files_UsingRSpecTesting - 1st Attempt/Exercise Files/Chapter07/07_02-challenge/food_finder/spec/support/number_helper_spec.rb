# encoding: UTF-8

describe 'NumberHelper' do

  include NumberHelper
  
  describe '#number_to_currency' do
    
    context 'using default values' do

      it "correctly formats an integer" do
        expect(number_to_currency(2000)).to eq('$2,000.00')
      end
      
      it "correctly formats a float" do
        expect(number_to_currency(9.99)).to eq('$9.99')
      end

      it "correctly formats a string" do
        expect(number_to_currency('99.99')).to eq('$99.99')
      end
      
      it "uses delimiters for very large numbers" do
        expect(number_to_currency(1000000)).to eq('$1,000,000.00')
      end

      it "does not have delimiters for small numbers" do
        expect(number_to_currency(1.99)).to eq('$1.99')
      end

    end
    
    context 'using custom options' do
      
      it 'allows changing the :unit' do
        expect(number_to_currency(100, {unit: '*$*'})).to eq('*$*100.00')
      end

      it 'allows changing the :precision' do
        expect(number_to_currency(1999.12345678, {precision: 8})).to eq('$1,999.12345678')
      end
      
      it 'omits the separator if :precision is 0' do
        expect(number_to_currency(99.99, {precision: 0})).to eq('$99')
      end
      
      it 'allows changing the :delimiter' do
        expect(number_to_currency(1000000, {delimiter: '-'})).to eq('$1-000-000.00')
      end
      
      it 'allows changing the :separator' do
        expect(number_to_currency(99.99, {separator: '*'})).to eq('$99*99')
      end
            
      it 'correctly formats using multiple options' do
        expect(number_to_currency(1000000, {unit: '%', precision: 4, delimiter: '-', separator: '*'})).to eq('%1-000-000*0000')
      end
      
    end
    
  end
  
end
