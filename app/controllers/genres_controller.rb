class GenresController < ApplicationController
  before_action :set_genre, only: %i[ show edit update destroy ]

  def index
    @genres = Genre.order(:name)
    @q = Genre.ransack(params[:q])

    genre_name = params.dig(:q, :books_genres_name_eq)
    @genre = @q.result(distinct: true).find_by(name: genre_name)

    @books = @genre.books.order(:title).paginate(page: params[:page], per_page: 20) if @genre.present?
  end

  def show
  end

  def new
    @genre = Genre.new
  end

  def edit
  end

  def create
    @genre = Genre.new(genre_params)

    respond_to do |format|
      if @genre.save
        format.html { redirect_to new_book_path(params[:book]), notice: "#{@genre.name} has been added" }
        format.json { render :show, status: :created, location: @genre }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @genre.update(genre_params)
        format.json { render inline: "location.reload();" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @genre.destroy

    respond_to do |format|
      format.json { render inline: "location.reload();" }
    end
  end

  private
    def set_genre
      @genre = Genre.find(params[:id])
    end

    def genre_params
      params.require(:genre).permit(:name)
    end
end
