require 'spec_helper'

describe MoviesController, :type => :controller do
  describe 'Find Movies With Same Director' do
    before :each do
      @fake_results = FactoryGirl.build(:movie, :id => 1, :title => 'LOL', :director => 'LOL')
    end
    it 'should call the model method that finds movies with the same director' do
      Movie.should_receive(:find).with('1').and_return(@fake_results)
      get :similar, { :id => '1' }
    end
    it 'should select the Similar Director for rendering' do
      Movie.stub(:find).and_return(@fake_results)
      get :similar, { :id => '1' }
      response.should render_template('similar')
    end
    it 'should make the Similar Director results available to that template' do
        movie = Movie.create!(:rating => 'R', :director => 'HAA')
        get :similar, { :id => movie.id }
        assigns(:movies).should eq [movie]
    end
    it 'should redirect to homepage if no director' do
        movie = Movie.create!
        get :similar, :id => movie.id
        response.should redirect_to movies_path
    end
  end
  describe 'Create a movie' do
    before :each do
      @fake_movie = FactoryGirl.build(:movie, :id => 1, :title => 'Inception', :director => 'Who knows?')
    end
    it 'should call the model method that creates a new movie' do
      Movie.should_receive(:create!).with("movie").and_return(@fake_movie)
      post :create, { :movie => "movie" }
    end
    it 'should redirect to the homepage' do
        Movie.stub(:create!).with("film").and_return(@fake_movie)
        post :create, { :movie => "film" }
        response.should redirect_to movies_path
    end
  end
  describe 'Update a movie' do
    before :each do
      @fake_movie = FactoryGirl.build(:movie, :id => 1, :title => 'Inception', :director => 'Who knows?')
    end
    it 'should call the model metod that updates a movie' do
      Movie.should_receive(:find).with('1').and_return(@fake_movie)
      put :update, :id => '1', :movie => {:title => 'LOL'}
    end
    it 'should update the title' do
      Movie.stub(:find).with('1').and_return(@fake_movie)
      @fake_movie.should_receive :update_attributes!
      put :update, :id => '1', :movie => {:title => 'LOL'}
    end
    it 'should redirect to the movie page' do
      Movie.stub(:find).with('1').and_return(@fake_movie)
      put :update, :id => '1', :movie => {:title => 'LOL'}
      response.should redirect_to movie_path(@fake_movie.id)
    end
  end
  describe 'Delete a movie' do
    before :each do
      @fake_movie = FactoryGirl.build(:movie, :id => 1, :title => 'Inception', :director => 'Who knows?')
    end
    it 'should call the model method that destroys a movie' do
      Movie.stub(:find).with('1').and_return @fake_movie
      put :destroy, :id => '1'
    end
    it 'should redirect to the homepage' do
        Movie.stub(:find).with('1').and_return(@fake_movie)
        post :destroy, { :id => '1' }
        response.should redirect_to movies_path
    end
  end
  describe 'Show a movie' do
    fixtures :movies
    it 'should show a movie info' do
      movie = movies(:my_movie)
      Movie.stub(:show).with('1').and_return(movie)
      get :show, { :id => '1' }
    end
  end
  describe 'Show movies list' do
    fixtures :movies
    it 'should sort movies by title and show R rated ones' do
      movie = movies(:my_movie)
      session[:sort] = "title"
      session[:ratings] = { "R" => "1"}
      get :index, :sort => session[:sort], :ratings => session[:ratings]
      assigns(:movies).should eq [movie]
    end
    it 'should show R rated movies and sort them by date' do
      movie = movies :my_movie
      session[:sort] = "release_date"
      session[:ratings] = {"R" => "1"}
      get :index, :sort => session[:sort], :ratings => session[:ratings]
    end
    it 'has no ratings parameters' do
      session[:sort] = "release_date"
      session[:ratings] = {"R" => "1"}
      get :index, :sort => session[:sort]
      response.should redirect_to(movies_path(:sort => session[:sort], :ratings => session[:ratings]))
     end
  it 'has no sort params' do
     session[:sort] = "release_date"
     session[:ratings] = {"R" => "1"}
     get :index, :ratings => session[:ratings]
     response.should redirect_to(movies_path(:sort => session[:sort], :ratings => session[:ratings]))
    end
  end
  describe 'Edit should be tested too ;)' do
    it 'should be tested' do
      get :edit, :id => 1
    end
  end
end
