class Books::ReadingListController < BooksController
  def index
    @to_be_read = Book.in_state(:tbr)
  end

  def add_book
  end

  def update_list
    book = Book.find(params[:book_id])
    if book.transition_to!(:tbr)
      redirect_to root_path, notice: "#{book.title} added to reading list"
    end
  end
end