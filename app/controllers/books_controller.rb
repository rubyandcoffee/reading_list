class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy remove_from_shelf update_rating ]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).includes(:genres, :author).order(:title).paginate(page: params[:page], per_page: 20)
  end

  def show
  end

  def new
    @book = Book.new
    @book.build_rental
  end

  def edit
    @book.build_rental(loaner: Loaner.first) unless @book.rental
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_url, notice: "#{@book.title} has been added to your bookshelf" }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_url, notice: "#{@book.title} has been updated" }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @book.really_destroy!
      flash[:notice] = 'Book deleted successfully'
      redirect_to books_path
    else
      flash[:alert] = 'Error deleting book'
      redirect_to books_path
    end
  end

  def buy
    @books = Book.where(purchased: false)
  end

  def unrated
    @books = Book.where(status: 'read', rating: nil)
  end
  def update_rating
    if @book.update(rating: params[:rating])
      flash[:notice] = "Rating updated"
      render json: { rating: @book.rating }, status: :ok
    else
      flash[:notice] = 'Failed to update rating'
      render json: { error: 'Failed to update rating' }, status: :unprocessable_entity
    end
  end

  def export
    @books = Book.where(purchased: false)

    respond_to do |format|
      format.html
      format.pdf do
        # Rails 7
        # https://github.com/mileszs/wicked_pdf/issues/1005
        render pdf: "Your Shopping List #{Date.current.strftime('%d/%m/%Y')}", # filename
               template: "books/shopping_list/printable",
               layout: 'pdf',
               formats: [:html],
               disposition: :inline
      end
    end
  end

  def import
    return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    CsvImportService.new.import_book(params[:file])

    redirect_to request.referer, notice: 'Successfully imported books'
  end

  def yearly_goals
    @book_goals = BookGoal.this_year
    @books = Book.with_deleted.joins(:book_goals).where(book_goals: { year: DateTime.now.year}).order(:title).paginate(page: params[:page], per_page: 20)
  end

  def generator
    book = Book.where(status: 'unread').pluck(:id).sample
    @book = Book.find(book)
  end

  def reviews
    @books = Book.where.not(rating: nil)
  end

  def remove_from_shelf
    if @book.destroy
      render json: { message: 'Book removed from shelf', redirect_url: books_path }, status: :ok
    else
      render json: { message: 'Error removing book' }, status: :unprocessable_entity
    end
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :total_pages, :author_id, :status, :rating, :series_id, :series_position, :purchased, genre_ids: [], book_goals_attributes: [:id, :month, :year, :_destroy], rental_attributes: [:id, :loaner_id, :active])
    end
end
