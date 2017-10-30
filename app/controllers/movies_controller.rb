class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
   
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    @all_ratings = Movie.distinct.pluck(:rating)
    ratings = params[:ratings]
    if ratings == nil
      @movies = Movie.all
    else
      @movies = Movie.where(rating: ratings.keys)
    end
    
    
  end
  
  def title_header
    @all_ratings = Movie.distinct.pluck(:rating)
    #code to control the highlight in the view
    ratings = params[:ratings]
    if ratings == nil
      @movies = Movie.all.order(:title)
    else
      @movies = Movie.where(rating: ratings.keys).order(:title)
    end
    @highlightTitle = "hilite"
    #sort code, send to title_header.haml
    render :index # title_header.haml
  end
  
  def release_date_header
    @all_ratings = Movie.distinct.pluck(:rating)
    @highlightReleaseDate = "hilite"
    ratings = params[:ratings]
    if ratings == nil
      @movies = Movie.all.order(:title)
    else
      @movies = Movie.where(rating: ratings.keys).order(:release_date)
    end
    #sort code, send to release_date_header.haml
    render :index
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
