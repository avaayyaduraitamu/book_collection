require "test_helper"

class BookTest < ActiveSupport::TestCase
  # Title Tests - Sunny Day
  test "should save book with valid title" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", 
                    price: 10.99, published_date: Date.new(1925, 4, 10))
    assert book.save
  end

  # Title Tests - Rainy Day
  test "should not save book without title" do
    book = Book.new(author: "F. Scott Fitzgerald", price: 10.99, 
                    published_date: Date.new(1925, 4, 10))
    assert_not book.save
    assert book.errors[:title].any?
  end

  # Author Tests - Sunny Day
  test "should save book with valid author" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", 
                    price: 10.99, published_date: Date.new(1925, 4, 10))
    assert book.save
  end

  # Author Tests - Rainy Day
  test "should not save book without author" do
    book = Book.new(title: "The Great Gatsby", price: 10.99, 
                    published_date: Date.new(1925, 4, 10))
    assert_not book.save
    assert book.errors[:author].any?
  end

  # Price Tests - Sunny Day
  test "should save book with valid price" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", 
                    price: 10.99, published_date: Date.new(1925, 4, 10))
    assert book.save
  end

  # Price Tests - Rainy Day (blank)
  test "should not save book without price" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", 
                    published_date: Date.new(1925, 4, 10))
    assert_not book.save
    assert book.errors[:price].any?
  end

  # Price Tests - Rainy Day (negative)
  test "should not save book with negative price" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", 
                    price: -5.00, published_date: Date.new(1925, 4, 10))
    assert_not book.save
    assert book.errors[:price].any?
  end

  # Price Tests - Rainy Day (zero)
  test "should not save book with zero price" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", 
                    price: 0.00, published_date: Date.new(1925, 4, 10))
    assert_not book.save
    assert book.errors[:price].any?
  end

  # Published Date Tests - Sunny Day
  test "should save book with valid published_date" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", 
                    price: 10.99, published_date: Date.new(1925, 4, 10))
    assert book.save
  end

  # Published Date Tests - Rainy Day
  test "should not save book without published_date" do
    book = Book.new(title: "The Great Gatsby", author: "F. Scott Fitzgerald", 
                    price: 10.99)
    assert_not book.save
    assert book.errors[:published_date].any?
  end
end
