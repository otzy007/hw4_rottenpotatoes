require 'spec_helper'

describe MoviesHelper do
  describe 'Odd numbers :D' do
    it 'should return odd for 3' do
      oddness(3).should eq "odd"
    end
  end
end
