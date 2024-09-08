class RentalsController < ApplicationController
  before_action :set_book
  before_action :set_rental, only: :destroy

  def destroy
    if @rental.destroy
      flash[:notice] = 'Rental deleted successfully'
      redirect_to edit_book_path(@book)
    else
      flash[:alert] = 'Error deleting rental'
      redirect_to edit_book_path(@book)
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_rental
    @rental = @book.rental
  end
end
