class RemoveGenreIdFromBooks < ActiveRecord::Migration[7.0]
  def change
    Book.all.each do |book|
      if book.genre_id.present?
        genre = Genre.find_by(id: book.genre_id)

        if genre && !book.genres.include?(genre)
          book.genres << genre
        end
      end
    end

    remove_column :books, :genre_id, :integer
  end
end
