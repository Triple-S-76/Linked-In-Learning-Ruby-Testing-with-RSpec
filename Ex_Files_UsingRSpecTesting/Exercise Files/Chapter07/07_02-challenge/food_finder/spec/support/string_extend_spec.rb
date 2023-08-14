describe 'String' do

  describe "#titleize" do

    
    it "capitalizes each word in a string" do
      new_string = 'this is a string'
      expect(new_string.titleize).to eq('This Is A String')
    end
    
    it "works with single-word strings" do
      new_string = 'string'
      expect(new_string.titleize).to eq('String')
    end
    
    it "capitalizes all uppercase strings" do
      new_string = 'ALL UPPERCASE STRING'
      expect(new_string.titleize).to eq('All Uppercase String')
    end
    
    it "capitalizes mixed-case strings" do
      new_string = 'MiXeD CaSe StRiNg'
      expect(new_string.titleize).to eq('Mixed Case String')
    end
    
  end
  
  describe '#blank?' do

    it "returns true if string is empty" do
      new_string = ''
      expect(new_string.blank?).to be true
    end

    it "returns true if string contains only spaces" do
      new_string = '       '
      expect(new_string.blank?).to be true
    end

    it "returns true if string contains only tabs" do
      new_string = "\t\t\t"
      expect(new_string.blank?).to be true
    end
    # Get a tab using a double-quoted string with \t
    # example: "\t\t\t"

    it "returns true if string contains only spaces and tabs" do
      new_string = "   \t   \t   \t   "
      expect(new_string.blank?).to be true
    end
    
    it "returns false if string contains a letter" do
      new_string = 't'
      expect(new_string.blank?).to be false
    end

    it "returns false if string contains a number" do
      new_string = '5'
      expect(new_string.blank?).to be false
    end
    
  end
  
end
