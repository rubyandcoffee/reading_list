class RatingService
  def self.rate_records(model, rating, attribute)
    records = []

    begin
      records << model.joins(:books)
                      .where(books: { rating: rating })
                      .group("#{model.table_name}.id")
                      .order('COUNT(books.id) DESC')
                      .limit(3)
                      .select("#{model.table_name}.*, COUNT(books.id) as books_count, #{attribute}")

      rating = adjust_rating(rating)
    end while records.flatten.count < 3

    records.flatten
  end

  private

  def self.adjust_rating(rating)
    if rating == 5
      rating - 1
    elsif rating == 1
      rating + 1
    else
      rating
    end
  end
end
