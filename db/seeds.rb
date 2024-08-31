# db/seeds.rb

# Method to create authors
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

# Method to create books
def create_books
  books_data = [
    { title: "The Old Man and the Sea", author_surname: "Hemingway" },
    { title: "Pride and Prejudice", author_surname: "Austen" },
    { title: "War and Peace", author_surname: "Tolstoy" },
    { title: "Harry Potter and the Philosopher's Stone", author_surname: "Rowling" },
    { title: "Adventures of Huckleberry Finn", author_surname: "Twain" }
  ]

  books_data.each do |book|
    author = Author.find_by(surname: book[:author_surname])

    if author
      Book.create!(title: book[:title], author_id: author.id)
    else
      puts "Author not found for book: #{book[:title]}"
    end
  end
end

# Create Loaners
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

# Method to create rentals
def create_rentals
  rentals_data = [
    { book_id: Book.find_by(title: "The Old Man and the Sea").id, loaner_id: Loaner.first.id },
    { book_id: Book.find_by(title: "Pride and Prejudice").id, loaner_id: Loaner.first.id },
    { book_id: Book.find_by(title: "War and Peace").id, loaner_id: Loaner.first.id },
    { book_id: Book.find_by(title: "Harry Potter and the Philosopher's Stone").id, loaner_id: Loaner.first.id },
    { book_id: Book.find_by(title: "Adventures of Huckleberry Finn").id, loaner_id: Loaner.first.id }
  ]

  rentals_data.each do |rental|
    Rental.create!(rental)
  end
end

# Method to create series


# Run the methods to seed data
create_authors
create_books
create_loaners
create_rentals
create_series
