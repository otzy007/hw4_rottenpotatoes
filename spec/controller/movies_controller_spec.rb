require 'spec_helper'

describe MoviesController, :type => :controller do
  describe 'Find Movies With Same Director' do
    before :each do
      @fake_results = [mock('Movie'), mock('Movie')]
    end
    it 'should call the model method that finds movies with the same director' do
      Movie.should_receive(:similar).with(1).and_return(@fake_results)
      get :similar, { :id => '1' }
    end
    it 'should select the Similar Director for rendering' do
      Movie.stub(:similar).and_return(@fake_results)
      get :similar, { :id => '1' }
      response.should render_template('similar')
    end
    it 'should make the Similar Director results available to that template' do
        Movie.stub(:similar).and_return(@fake_results)
        get :similar, { :id => '1'}
        assigns(:movies).should == @fake_results
    end
  end
end

