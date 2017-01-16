RSpec.describe Version do
  describe '#initialize' do
    it 'does not raise error with empty string' do
      expect { Version.new '' }.to_not raise_error
    end
  end
  describe '#version' do
    it 'can look for valid versions' do
      input = '1.2.1'
      expect(Version.new(input).components.to_s).to eq '[1, 2, 1]'
    end
	it 'creates valid versions without arguments' do
      expect { Version.new }.not_to raise_error
      expect { Version.new '' }.not_to raise_error
    end
    it 'can look for valid versions with zeros' do
      input = '1.2.0'
      expect(Version.new(input).components.to_s).to eq '[1, 2]'
    end
    it 'can look for wrong versions .3' do
      output = "Invalid version string \'.3\'"
      expect { Version.new('.3') }.to raise_error(ArgumentError, output)
    end
    it 'can look for wrong versions 0..3' do
      output = "Invalid version string \'0..3\'"
      expect { Version.new('0..3') }.to raise_error(ArgumentError, output)
    end
  end
  describe '#comparing' do
    it 'can compare correctly using #<' do
      expect(Version.new('1.2.3') < Version.new('1.3.1')).to eq true
    end
    it 'can compare correctly using #<' do
      expect(Version.new('4.2.3') < Version.new('3.3.1')).to eq false
    end
    it 'can compare correctly using #>' do
      expect(Version.new('1.2.3') > Version.new('1.2.0')).to eq true
    end
    it 'can compare correctly using #>' do
      expect(Version.new('7.2.0') > Version.new('8.2.0')).to eq false
    end
    it 'can compare correctly using #==' do
      expect(Version.new('1.2.3') == Version.new('1.0.3')).to eq false
    end
    it 'can compare correctly using #>=' do
      expect(Version.new('1.2.3') >= Version.new('1.0.3')).to eq true
    end
    it 'can compare correctly using #<=' do
      version1 = Version.new('1.3.1')
      version2 = Version.new('1.3.1.0')
      version3 = Version.new('1.3.1.1.2')
	  
      expect(version1 <= version2).to be true
      expect(version3 <= version1).to be false
    end
	it "can compare correctly using #<=>" do
      version1 = Version.new('1.2.3.0.1')
      version2 = Version.new('1.3.1')
      version3 = Version.new('1.3.1.0')
      version4 = Version.new('1.3.1.1.2')
      expect( version1 <=> version2 ).to eq -1
      expect( version2 <=> version3 ).to eq 0
      expect( version4 <=> version2 ).to eq 1
    end
  end
  describe '#converting' do
    it 'can convert from 1.2.3' do
      expect(Version.new('1.2.3').components.to_s).to eq '[1, 2, 3]'
    end
    it 'can convert from 1.2.0' do
      expect(Version.new('1.2.0').components.to_s).to eq '[1, 2]'
    end
    it 'can convert from 1.0.0' do
      expect(Version.new('1.0.0').components.to_s).to eq '[1]'
    end
    it 'can convert from 4.0.3' do
      expect(Version.new('4.0.3').components.to_s).to eq '[4, 0, 3]'
    end
  end
  describe '#components' do
    it 'can return correctly 2 of 2 components' do
      expect(Version.new('4.5').components.to_s).to eq '[4, 5]'
    end
    it 'can return correctly 3 of 4 components' do
      expect(Version.new('4.0.3.0').components.to_s).to eq '[4, 0, 3]'
    end
  end
  describe Version::Range do
    describe 'Range#include?' do
      it 'can include correctly numbers' do
        first = Version.new('1')
        second = Version.new('2')
        third = Version.new('1.5')
        expect((Version::Range.new(first, second).include? third)).to eq true
      end
      it 'can include correctly numbers' do
        first = Version.new('1')
        second = Version.new('1.2.3')
        third = Version.new('1.1.2')
        expect((Version::Range.new(first, second).include? third)).to eq true
      end
      it 'can include correctly numbers' do
        first = Version.new('2.3.4')
        second = Version.new('2')
        third = Version.new('1.5')
        expect((Version::Range.new(first, second).include? third)).to eq false
      end
      it 'can include correctly numbers' do
        first = Version.new('2')
        second = Version.new('3.4.4')
        third = Version.new('3.4.0')
        expect((Version::Range.new(first, second).include? third)).to eq true
      end
	  it 'checks if a range includes a version' do
        range = Version::Range.new(Version.new('1'), Version.new('2'))
        expect(range).to include(Version.new('1.5.4.3.2.3.4.5.1.0'))
        expect(range).to include('1.2.3.4.1')
        expect(range).to_not include('0.9.9.9.9.9.9.9')
        expect(range).to_not include(Version.new('2.0.0.1'))
      end
    end
    describe 'Range#to_a' do
      it 'can return correctly all numbers between 1.1.0 and 1.2.2' do
        first = Version.new('1.1.0')
        second = Version.new('1.2.2')
        output = [
          '1.1', '1.1.1', '1.1.2', '1.1.3', '1.1.4', '1.1.5', '1.1.6',
          '1.1.7', '1.1.8', '1.1.9', '1.2', '1.2.1'
        ]
        expect(Version::Range.new(first, second).to_a).to eq output
      end
      it 'can return correctly all numbers between 1.4.5 and 1.5.5' do
        first = Version.new('1.4.5')
        second = Version.new('1.5.5')
        output = [
          '1.4.5', '1.4.6', '1.4.7', '1.4.8', '1.4.9', '1.5', '1.5.1',
          '1.5.2', '1.5.3', '1.5.4'
        ]
        expect(Version::Range.new(first, second).to_a).to eq output
      end
      it 'can return correctly all numbers between 1.1.0 and 1.1' do
        first = Version.new('1.1.0')
        second = Version.new('1.1')
        output = []
        expect(Version::Range.new(first, second).to_a).to eq output
      end
      it 'can return correctly all numbers between 1.1 and 1.2' do
        first = Version.new('1.1')
        second = Version.new('1.2')
        output = [
          '1.1', '1.1.1', '1.1.2', '1.1.3', '1.1.4', '1.1.5', '1.1.6',
          '1.1.7', '1.1.8', '1.1.9'
        ]
        expect(Version::Range.new(first, second).to_a).to eq output
      end
	  it 'works with 3 components only' do
        range = Version::Range.new(Version.new('1.1'), Version.new('1.2'))
        expect(range.to_a).to eq [
          '1.1', '1.1.1', '1.1.2',
          '1.1.3', '1.1.4', '1.1.5',
          '1.1.6', '1.1.7', '1.1.8', '1.1.9'
        ]
      end
      it "doesn't include first version if it is the same like the last one" do
        range = Version::Range.new(Version.new('0'), Version.new('0'))
        expect(range.to_a).to eq []
      end
	  it "can works with strings" do
        range = Version::Range.new('0', '0.0.9')
        expect(range.to_a).to eq [
          '0', '0.0.1', '0.0.2',
          '0.0.3', '0.0.4', '0.0.5',
          '0.0.6', '0.0.7', '0.0.8'
        ]
      end
    end
  end
end