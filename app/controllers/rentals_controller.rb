class RentalsController < ApplicationController
  before_action :set_book
  before_action :set_rental, only: :destroy

  def destroy
    if @rental.destroy
      render json: { message: 'You are no longer renting this book' }, status: :ok
    else
      render json: { message: 'Error removing rental' }, status: :unprocessable_entity
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
