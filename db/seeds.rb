# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Booklist.destroy_all
Book.destroy_all
List.destroy_all
User.destroy_all

require "json"
require "open-uri"

subjects = ["fiction", "science", "history", "art", "biography", "technology", "philosophy", "music", "travel", "sports"]

subjects.each do |subject|
  url = "https://www.googleapis.com/books/v1/volumes?q=subject:#{subject}&maxResults=40"
  book_serialized = URI.parse(url).read
  respons = JSON.parse(book_serialized)
  books = respons["items"]
  books.each do |book|
    Book.create!(
        title: book["volumeInfo"]["title"],
        description: book["volumeInfo"]["description"],
        genre: book["volumeInfo"]["categories"]&.join(", "),
        release_date: book["volumeInfo"]["publishedDate"],
        picture: (book["volumeInfo"]["imageLinks"]["thumbnail"] if book["volumeInfo"]["imageLinks"]),
        book_length: book["volumeInfo"]["pageCount"],
        author: book["volumeInfo"]["authors"]&.join(", "),
      )
  end
end


# book1 = Book.create!(title: "To Kill a Mockingbird", description: "A novel about racial injustice in the Deep South.", genre: "Fiction", release_date: "1960-07-11", author: "Harper Lee", picture: "https://d32vymxhv9fq6b.cloudfront.net/images/books/large/97800/9780099466734.jpg", book_length: 281)
# book2 = Book.create!(title: "1984", description: "A dystopian novel about totalitarianism.", genre: "Dystopian", release_date: "1949-06-08", author: "George Orwell", picture: "https://www.theoriginalunderground.com/cdn/shop/files/1984-george-orwell-cover-print-579534_1024x1024.jpg?v=1729242194", book_length: 328)
# book3 = Book.create!(title: "The Great Gatsby", description: "A critique of the American Dream.", genre: "Classic", release_date: "1925-04-10", author: "F. Scott Fitzgerald", picture: "https://m.media-amazon.com/images/I/61z0MrB6qOS._SL1500_.jpg", book_length: 180)
# book4 = Book.create!(title: "Moby Dick", description: "A whaling adventure and a deep exploration of obsession.", genre: "Adventure", release_date: "1851-10-18", author: "Herman Melville", picture: "https://m.media-amazon.com/images/I/71VZkXCZt8L.jpg", book_length: 635)
# book5 = Book.create!(title: "Pride and Prejudice", description: "A romance novel that critiques societal norms.", genre: "Romance", release_date: "1813-01-28", author: "Jane Austen", picture: "https://m.media-amazon.com/images/I/812wzoJvRLL._SL1396_.jpg", book_length: 432)
# book6 = Book.create!(title: "War and Peace", description: "A historical novel about Napoleon's invasion of Russia.", genre: "Historical", release_date: "1869-01-01", author: "Leo Tolstoy", picture: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQYo0KgeOMsR2fcGXR_PY88iqJGCTTDFCzyFMLPOQd4WT195P63p2cBoytF2NPba6T5O0wIpr0n6pFBMHURq0NNY8kYSLiNY24n0Zb6F56Gh0uYIVE-GiuD&usqp=CAc", book_length: 1225)
# book7 = Book.create!(title: "Crime and Punishment", description: "A psychological thriller exploring morality.", genre: "Psychological", release_date: "1866-01-01", author: "Fyodor Dostoevsky", picture: "https://m.media-amazon.com/images/I/71O2XIytdqL._SL1500_.jpg", book_length: 671)
# Book.create!(title: "The Catcher in the Rye", description: "A coming-of-age novel.", genre: "Classic", release_date: "1951-07-16", author: "J.D. Salinger", picture: "https://m.media-amazon.com/images/I/91fQEUwFMyL._SL1500_.jpg", book_length: 277)
# Book.create!(title: "Brave New World", description: "A dystopian novel about a future society.", genre: "Dystopian", release_date: "1932-01-01", author: "Aldous Huxley", picture: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRxe4B5hhq96EqWDILUtmvwSkXx88yMzXBzB0McEAI2uKBY8GQPUUA02GEoaarrlVmMMdN4BvL2nr2mmjoBxpPkFb6LOorIMeo7MLJKSH0dVEZ-v4jusSoh&usqp=CAc", book_length: 311)
# Book.create!(title: "The Hobbit", description: "A fantasy adventure before The Lord of the Rings.", genre: "Fantasy", release_date: "1937-09-21", author: "J.R.R. Tolkien", picture: "https://m.media-amazon.com/images/I/81uEDUfKBZL._SL1500_.jpg", book_length: 310)
# Book.create!(title: "Fahrenheit 451", description: "A dystopian novel about book burning.", genre: "Dystopian", release_date: "1953-10-19", author: "Ray Bradbury", picture: "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTor-QzRdsh50XpUUoLJ8KABeygUNrMZFCG44l8y-HOmAQaZLmIgipj47mLxvxl2vwY0I0FBEYnT9KPej-T9iJMVkkAzNW9RiqhQ54itNdKIxwrbT4WTN5e6Q&usqp=CAc", book_length: 249)
# Book.create!(title: "The Lord of the Rings", description: "An epic fantasy trilogy.", genre: "Fantasy", release_date: "1954-07-29", author: "J.R.R. Tolkien", picture: "https://m.media-amazon.com/images/I/81j4C6j3dRL._SL1500_.jpg", book_length: 1137)
# Book.create!(title: "Dracula", description: "The original vampire novel.", genre: "Horror", release_date: "1897-05-26", author: "Bram Stoker", picture: "https://ralphiesfunhouse.com/cdn/shop/files/dracula-original-book-cover-print-667367_900x.jpg?v=1742187052", book_length: 418)
# Book.create!(title: "Frankenstein", description: "A Gothic novel about science and ethics.", genre: "Gothic", release_date: "1818-01-01", author: "Mary Shelley", picture: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTeZxRd_YmPblFF6PFtUHEScoVZlJMXb42521MVXe4HGCRQAS7SPzqEoz19rXVVi1pzTZR9uRSxqu5cqtGdicrRwiJmfflTGVkW-T9K1UznMa4G_YSDc8KmxQ&usqp=CAc", book_length: 280)
# Book.create!(title: "The Picture of Dorian Gray", description: "A novel about vanity and morality.", genre: "Philosophical", release_date: "1890-06-20", author: "Oscar Wilde", picture: "https://m.media-amazon.com/images/I/71fm0Ap7JcL._SL1360_.jpg", book_length: 254)
# Book.create!(title: "The Road", description: "A post-apocalyptic survival story.", genre: "Post-Apocalyptic", release_date: "2006-09-26", author: "Cormac McCarthy", picture: "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSFYaur_6k0qnMp6VQcUJuMKpoS9NLn4so4krDqqiilwhdf8YNnU-G2D0ZhxWmte-k3-Nax73FhOkviePqtFQbnulb5S1L4yPK9NYyVOY5ILAVEH8Wc1se3&usqp=CAc", book_length: 287)
# Book.create!(title: "The Alchemist", description: "A novel about following dreams.", genre: "Philosophical", release_date: "1988-01-01", author: "Paulo Coelho", picture: "https://m.media-amazon.com/images/I/81UGPuNl7kL._SL1500_.jpg", book_length: 208)
# Book.create!(title: "A Tale of Two Cities", description: "A novel about the French Revolution.", genre: "Historical", release_date: "1859-01-01", author: "Charles Dickens", picture: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRugGc5ytxvTJ6vEh401QhF4uD5CI-_l0CVOA-29uJ7WspkRt7MYG67B5PpeJ-D6NnrL-11AsB1et2nMo1OzzI4Yq7qcFy3EyWWcEveV-0&usqp=CAc", book_length: 489)
# Book.create!(title: "The Count of Monte Cristo", description: "A classic tale of revenge.", genre: "Adventure", release_date: "1844-01-01", author: "Alexandre Dumas", picture: "https://m.media-amazon.com/images/I/811iBn28JdL._SL1500_.jpg", book_length: 1276)
# Book.create!(title: "Wuthering Heights", description: "A Gothic novel of passion and revenge.", genre: "Gothic", release_date: "1847-12-01", author: "Emily Brontë", picture: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTR0MUhJBe-JcLyiX2ejsOv-b-WaPi-zdPdjYLzTesNfi5yFgQyP9rlOzFKzsiCxG9OVdEoLDvnF5_Cys0fq_Why8EN-nc1eqnzvXpL5ghJvtt2tyyN99SVGQ&usqp=CAc", book_length: 416)

User.create!(email: "user1@example.com", password: "password", first_name: "John", last_name: "Doe", username: "johndoe1", picture: "", bio: "Avid reader and writer.")
User.create!(email: "user2@example.com", password: "password", first_name: "Jane", last_name: "Smith", username: "janesmith2", picture: "", bio: "Lover of mystery novels.")
User.create!(email: "user3@example.com", password: "password", first_name: "Alice", last_name: "Johnson", username: "alicejohnson3", picture: "", bio: "Fantasy and sci-fi enthusiast.")
User.create!(email: "user4@example.com", password: "password", first_name: "Bob", last_name: "Brown", username: "bobbrown4", picture: "", bio: "Tech lover and non-fiction reader.")
User.create!(email: "user5@example.com", password: "password", first_name: "Charlie", last_name: "Davis", username: "charliedavis5", picture: "", bio: "Poetry and drama fan.")
User.create!(email: "user6@example.com", password: "password", first_name: "Debbie", last_name: "Miller", username: "debbie_miller6", picture: "", bio: "History buff with a passion for books.")
User.create!(email: "user7@example.com", password: "password", first_name: "Eve", last_name: "Taylor", username: "evetaylor7", picture: "", bio: "Psychology and sociology lover.")
User.create!(email: "user8@example.com", password: "password", first_name: "Frank", last_name: "Wilson", username: "frankwilson8", picture: "", bio: "Fan of modern and contemporary fiction.")
User.create!(email: "user9@example.com", password: "password", first_name: "Grace", last_name: "Moore", username: "gracemoore9", picture: "", bio: "Self-help and motivational books enthusiast.")
User.create!(email: "user10@example.com", password: "password", first_name: "Hank", last_name: "Taylor", username: "hanktaylor10", picture: "", bio: "Science fiction lover and technology buff.")

user1 = User.find_by(username: "johndoe1")
user2 = User.find_by(username: "janesmith2")
user3 = User.find_by(username: "alicejohnson3")
user4 = User.find_by(username: "bobbrown4")
user5 = User.find_by(username: "charliedavis5")

book1 = Book.find_by(title: "The Hobbit")
book2 = Book.find_by(title: "1984")
book3 = Book.find_by(title: "Brave New World")
book4 = Book.find_by(title: "The Catcher in the Rye")
book5 = Book.find_by(title: "To Kill a Mockingbird")

list1 = List.create!(user_id: user1.id, title: "Favorites", date: Date.today, description: "A list of my all-time favorite books.")
list2 = List.create!(user_id: user2.id, title: "To Read", date: Date.today, description: "Books I want to read in the near future.")
list3 = List.create!(user_id: user3.id, title: "Sci-Fi Picks", date: Date.today, description: "A list of the best science fiction novels.")
list4 = List.create!(user_id: user4.id, title: "Tech Books", date: Date.today, description: "Books about technology and innovation.")
list5 = List.create!(user_id: user5.id, title: "Poetry Collection", date: Date.today, description: "A collection of my favorite poetry books.")

booklist1 = Booklist.create(book: book1, list: list1)
booklist2 = Booklist.create(book: book2, list: list2)
booklist3 = Booklist.create(book: book3, list: list3)
booklist4 = Booklist.create(book: book4, list: list4)
booklist5 = Booklist.create(book: book5, list: list5)
