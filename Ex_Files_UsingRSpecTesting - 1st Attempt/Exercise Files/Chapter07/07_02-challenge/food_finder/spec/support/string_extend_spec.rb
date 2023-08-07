describe 'String' do

  describe "#titleize" do

    
    it "capitalizes each word in a string" do
      expect('this is a title!'.titleize).to eq('This Is A Title!')
    end
    
    it "works with single-word strings" do
      expect('test'.titleize).to eq('Test')
    end
    
    it "capitalizes all uppercase strings" do
      expect('TITLE'.titleize).to eq('Title')
    end
    
    it "capitalizes mixed-case strings" do
      expect('TiTlEiZe Me'.titleize).to eq('Titleize Me')
    end
    
  end
  
  describe '#blank?' do

    it "returns true if string is empty" do
      expect(''.blank?).to be true
    end

    it "returns true if string contains only spaces" do
      expect('     '.blank?).to be true
    end

    it "returns true if string contains only tabs" do
      # Get a tab using a double-quoted string with \t
      # example: "\t\t\t"
      expect("\t\t\t\t\t".blank?).to be true
    end

    it "returns true if string contains only spaces and tabs" do
      expect("\t\t\t   \t\t\t   \t\t\t".blank?).to be true
    end
    
    it "returns false if string contains a letter" do
      expect('a'.blank?).to be false
    end

    it "returns false if string contains a number" do
      expect('1'.blank?).to be false
    end
    
  end
  
end
