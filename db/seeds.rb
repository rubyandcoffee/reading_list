# db/seeds.rb

def create_authors
  authors_data = [
    { forename: "Ernest", surname: "Hemingway", gender: "Male", nationality: "American" },
    { forename: "Jane", surname: "Austen", gender: "Female", nationality: "British" },
    { forename: "Leo", surname: "Tolstoy", gender: "Male", nationality: "Russian" },
    { forename: "J.K.", surname: "Rowling", gender: "Female", nationality: "British" },
    { forename: "Mark", surname: "Twain", gender: "Male", nationality: "American" }
  ]

  authors_data.each do |author|
    Author.create!(author)
  end
end

def create_series
  series_data = [
    { title: "The Old Man and the Sea", series_name: nil },
    { title: "Pride and Prejudice", series_name: "Jane Austen Collection" },
    { title: "War and Peace", series_name: nil },
    { title: "Harry Potter and the Philosopher's Stone", series_name: "Harry Potter Series" },
    { title: "Adventures of Huckleberry Finn", series_name: nil }
  ]

  series_data.each do |series|
    Series.create!(series)
  end
end

def create_genres
  genres = [
    'Action',
    'Adventure',
    'Literary Fiction',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Thriller'
  ]

  genres.each do |genre_name|
    Genre.find_or_create_by(name: genre_name)
  end
end

def create_books
  books_data = [
    { title: "The Old Man and the Sea", author: Author.find_by_surname("Hemingway"), genre: Genre.find_by(name: 'Literary Fiction'), total_pages: 127 },
    { title: "Pride and Prejudice", author: Author.find_by_surname("Austen"), genre: Genre.find_by(name: 'Romance'), total_pages: 350 },
    { title: "War and Peace", author: Author.find_by_surname("Tolstoy"), genre: Genre.find_by(name: 'Literary Fiction'), total_pages: 1350 },
    { title: "Harry Potter and the Philosopher's Stone", author: Author.find_by_surname("Rowling"), genre: Genre.find_by(name: 'Fantasy'), total_pages: 223 },
    { title: "Adventures of Huckleberry Finn", author: Author.find_by_surname("Twain"), genre: Genre.find_by(name: 'Literary Fiction'), total_pages: 350 }
  ]

  books_data.each do |book|
    Book.create!(book)
  end
end

def create_loaners
  loaners_data = [
    { name: "Library" },
    { name: "Friend" },
    { name: "Family" }
  ]

  loaners_data.each do |loaner|
    Loaner.create!(loaner)
  end
end

def create_rentals
  rentals_data = [
    { book_id: Book.find_by(title: "The Old Man and the Sea").id, loaner_id: Loaner.first.id },
    { book_id: Book.find_by(title: "Pride and Prejudice").id, loaner_id: Loaner.second.id },
    { book_id: Book.find_by(title: "War and Peace").id, loaner_id: Loaner.third.id },
    { book_id: Book.find_by(title: "Harry Potter and the Philosopher's Stone").id, loaner_id: Loaner.first.id },
    { book_id: Book.find_by(title: "Adventures of Huckleberry Finn").id, loaner_id: Loaner.second.id }
  ]

  rentals_data.each do |rental|
    Rental.create!(rental)
  end
end

create_authors
create_genres
create_books
create_loaners
create_rentals
create_series
