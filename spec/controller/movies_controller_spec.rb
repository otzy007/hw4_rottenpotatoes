# spec_director.rb
#
require 'spec_helper'

describe MoviesController do
  describe 'Find Movies With Same Director' do
    it 'should call the model method that finds movies with the same director' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.should_receive(:similar).with('1').and_return(fake_results)
      get :similar, { :id => '1' }
    end
  end
end

