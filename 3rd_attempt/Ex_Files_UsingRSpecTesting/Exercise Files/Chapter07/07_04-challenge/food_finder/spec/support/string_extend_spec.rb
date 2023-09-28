describe 'String' do

  describe "#titleize" do

    it "capitalizes each word in a string" do
      phrase = 'Every word should be capitalized'
      expect = 'Every Word Should Be Capitalized'
      expect(phrase.titleize).to eq(expect)
    end
    
    it "works with single-word strings" do
      phrase = 'word'
      expect = 'Word'
      expect(phrase.titleize).to eq(expect)
    end
    
    it "capitalizes all uppercase strings" do
      phrase = 'I AM YELLING'
      expect = 'I Am Yelling'
      expect(phrase.titleize).to eq(expect)
    end
    
    it "capitalizes mixed-case strings" do
      phrase = 'WeIrD'
      expect = 'Weird'
      expect(phrase.titleize).to eq(expect)
    end
    
  end
  
  describe '#blank?' do

    it "returns true if string is empty" do
      phrase = ''
      expect(phrase).to be_blank
    end

    it "returns true if string contains only spaces" do
      phrase = '      '
      expect(phrase).to be_blank
    end

    it "returns true if string contains only tabs" do
      # Get a tab using a double-quoted string with \t
      # example: "\t\t\t"
      phrase = "\t\t\t"
      expect(phrase).to be_blank
    end

    it "returns true if string contains only spaces and tabs" do
      phrase = "   \t   \t   \t   "
      expect(phrase).to be_blank
    end
    
    it "returns false if string contains a letter" do
      phrase = 'g'
      expect(phrase).not_to be_blank
    end

    it "returns false if string contains a number" do
      phrase = '99'
      expect(phrase).not_to be_blank
    end
  end
  
end
