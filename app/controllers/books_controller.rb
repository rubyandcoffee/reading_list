class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).order(:title).paginate(page: params[:page], per_page: 20)
  end

  def show
  end

  def new
    @book = Book.new
    @book.build_rental
    @book.build_author unless @book.author
    @book.build_genre unless @book.genre
  end

  def edit
    if rental_params_present?
      @book.build_rental unless @book.rental
    end
  end

  def create
    @book = Book.new(book_params.except(:status))

    if rental_params_present?
      @book.build_rental(book_params[:rental])
    end

    respond_to do |format|
      if @book.save
        @book.state_machine.transition_to!(book_params[:status]) if book_params[:status].present?
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
      @book.state_machine.transition_to!(book_params[:status]) if book_params[:status].present?

      if @book.update(book_params.except(:status))
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

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book has been deleted" }
      format.json { head :no_content }
    end
  end

  def buy
    @books = Book.where(purchased: false)
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
    @books = Book.joins(:book_goals).where(book_goals: { year: DateTime.now.year}).order(:title).paginate(page: params[:page], per_page: 20)
  end

  def generator
    book = Book.includes(:book_transitions).where(book_transitions: { to_state: 'unread', most_recent: true }).pluck(:book_id).sample
    @book = Book.find(book)
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :total_pages, :author_id, :genre_id, :status, :rating, :series_id, :series_position, :purchased, book_goals_attributes: [:id, :month, :year, :_destroy], rental_attributes: [:id, :loaner_id, :active])
    end

  def rental_params_present?
    rental_params = params.dig(:book, :rental)
    rental_params && rental_params.values.any?(&:present?)
  end
end
