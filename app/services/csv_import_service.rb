require 'csv'

class CsvImportService
  def import_book(file)
    CSV.foreach(file.path, headers: true) do |row|
      # map the CSV columns to your database columns
      book_hash = {}
      book_hash[:title] = row['Title']
      book_hash[:author_id] = row['Author ID']
      book_hash[:genre_id] = row['Genre ID']
      book_hash[:rating] = row['Rating']
      book_hash[:series_id] = row['Series ID']
      book_hash[:series_position] = row['Series Position']
      book_hash[:total_pages] = row['Total Pages']

      Book.find_or_create_by!(book_hash)
      # for performance, you could create a separate job to import each book
      # CsvImportJob.perform_later(book_hash)
    end
  end

  def import_author(file)
    CSV.foreach(file.path, headers: true) do |row|

      # map the CSV columns to your database columns
      author_hash = {}
      author_hash[:forename] = row['Forename']
      author_hash[:surname] = row['Surname']
      author_hash[:gender] = row['Gender']
      author_hash[:nationality] = row['Nationality']

      Author.find_or_create_by!(author_hash)
      # for performance, you could create a separate job to import each author
      # CsvImportJob.perform_later(author_hash)
    end
  end
end