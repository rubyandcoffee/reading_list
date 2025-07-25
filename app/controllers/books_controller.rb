class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy remove_from_shelf update_rating ]

  def index
    @q = Book.not_deleted.ransack(params[:q])
    @books = @q.result(distinct: true).includes(:genres, :author).order(:title).paginate(page: params[:page], per_page: 20)
  end

  def show
  end

  def new
    # begin
    #   1 / 0
    # rescue ZeroDivisionError => exception
    #   Sentry.capture_exception(exception)
    # end
    
    # Sentry.capture_message("test message hi there 123")

    @book = Book.new
    @book.build_rental
  end

  def edit
    @book.build_rental unless @book.rental
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "#{@book.title} has been added to your bookshelf"
      respond_to do |format|
        format.html { redirect_to books_path }
        format.json { render json: @book, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new }
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
    @book.destroy
    flash[:notice] = "#{@book.title} has been removed from your bookshelf"
    head :no_content
  end

  def remove_from_shelf
    date_now = Time.now.strftime("%Y-%m-%d %H:%M:%S.%6N")

    if (@book.deleted_at = date_now)
      flash[:notice] = 'Book removed from shelf successfully'
      redirect_to books_path
    else
      flash[:alert] = 'Error removing book from shelf'
      redirect_to books_path
    end
  end

  def buy
    @books = Book.where(buy: true)
  end

  def todo
    per_page = 10
    @unrated_books = Book.unrated&.sort_by { |b| b.author.surname }.paginate(page: params[:page], per_page: per_page)
    @no_page_books = Book.where(total_pages: nil).paginate(page: params[:page], per_page: per_page)
    @no_genre_books = Book.left_outer_joins(:genres).where(genres: { id: nil }).paginate(page: params[:page], per_page: per_page)
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
    @books = Book.where(buy: true).sort_by { |b| b.author.surname }

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
    @books = Book
               .joins(:book_goals)
               .where(book_goals: { year: DateTime.now.year })
               .order(:title)
               .paginate(page: params[:page], per_page: 20)
  end

  def generator
    book = Book.not_deleted.where(status: 'unread').pluck(:id).sample
    @book = Book.find(book)
  end

  def reviews
    @books = Book.where.not(rating: nil)
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(
        :title, :total_pages, :author_id, :status, :rating, :series_id, :series_position,
        :purchased, :buy, :rental, :rental_source,
        genre_ids: [],
        book_goals_attributes: [:id, :month, :year, :_destroy],
        rental_attributes: [:id, :loaner_id, :active, :due_date]
      )
    end

    def author_params
      params.require(:author).permit(:forename, :surname, :nationality, :gender)
    end
end
