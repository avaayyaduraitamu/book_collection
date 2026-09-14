require "test_helper"

class BooksIntegrationTest < ActionDispatch::IntegrationTest
  # Sunny Day - Create Book with All Valid Attributes
  test "should create book with valid attributes and show success message" do
    get "/books/new"
    assert_response :success

    post "/books", params: { 
      book: { 
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        price: 10.99,
        published_date: Date.new(1925, 4, 10)
      } 
    }
    
    assert_redirected_to book_path(Book.last)
    follow_redirect!
    assert_response :success
    assert_match "Book was successfully created", @response.body
  end

  # Rainy Day - Create Book with Blank Title
  test "should not create book with blank title and show error" do
    post "/books", params: { 
      book: { 
        title: "",
        author: "F. Scott Fitzgerald",
        price: 10.99,
        published_date: Date.new(1925, 4, 10)
      } 
    }
    
    assert_response :unprocessable_entity
    assert_match "Title can&#39;t be blank", @response.body
  end

  # Rainy Day - Create Book with Blank Author
  test "should not create book with blank author and show error" do
    post "/books", params: { 
      book: { 
        title: "The Great Gatsby",
        author: "",
        price: 10.99,
        published_date: Date.new(1925, 4, 10)
      } 
    }
    
    assert_response :unprocessable_entity
    assert_match "Author can&#39;t be blank", @response.body
  end

  # Rainy Day - Create Book with Blank Price
  test "should not create book with blank price and show error" do
    post "/books", params: { 
      book: { 
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        price: "",
        published_date: Date.new(1925, 4, 10)
      } 
    }
    
    assert_response :unprocessable_entity
    assert_match "Price can&#39;t be blank", @response.body
  end

  # Rainy Day - Create Book with Negative Price
  test "should not create book with negative price and show error" do
    post "/books", params: { 
      book: { 
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        price: -5.00,
        published_date: Date.new(1925, 4, 10)
      } 
    }
    
    assert_response :unprocessable_entity
    assert_match "must be greater than 0", @response.body
  end

  # Rainy Day - Create Book with Blank Published Date
  test "should not create book with blank published_date and show error" do
    post "/books", params: { 
      book: { 
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        price: 10.99,
        published_date: ""
      } 
    }
    
    assert_response :unprocessable_entity
    assert_match "Published date can&#39;t be blank", @response.body
  end

  # Test GET /books (index)
  test "should show all books on index page" do
    book = Book.create!(title: "Test Book", author: "Test Author", 
                       price: 15.99, published_date: Date.new(2020, 1, 1))
    
    get "/books"
    assert_response :success
    assert_match "Test Book", @response.body
    assert_match "Test Author", @response.body
  end

  # Test GET /books/:id (show)
  test "should show individual book details" do
    book = Book.create!(title: "Test Book", author: "Test Author", 
                       price: 15.99, published_date: Date.new(2020, 1, 1))
    
    get "/books/#{book.id}"
    assert_response :success
    assert_match "Test Book", @response.body
    assert_match "Test Author", @response.body
    assert_match "15.99", @response.body
  end

  # Test PATCH /books/:id (update)
  test "should update book successfully" do
    book = Book.create!(title: "Old Title", author: "Old Author", 
                       price: 10.00, published_date: Date.new(2020, 1, 1))
    
    patch "/books/#{book.id}", params: { 
      book: { 
        title: "New Title",
        author: "New Author",
        price: 20.00,
        published_date: Date.new(2021, 1, 1)
      } 
    }
    
    assert_redirected_to book_path(book)
    follow_redirect!
    assert_match "Book was successfully updated", @response.body
    
    book.reload
    assert_equal "New Title", book.title
    assert_equal "New Author", book.author
    assert_equal 20.00, book.price
  end

  # Test DELETE /books/:id (delete)
  test "should delete book successfully" do
    book = Book.create!(title: "Test Book", author: "Test Author", 
                       price: 15.99, published_date: Date.new(2020, 1, 1))
    book_id = book.id
    
    delete "/books/#{book_id}"
    
    assert_redirected_to books_path
    follow_redirect!
    assert_match "Book was successfully deleted", @response.body
    assert_nil Book.find_by(id: book_id)
  end
end
