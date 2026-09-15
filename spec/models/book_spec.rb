
# spec/models/book_spec.rb
require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:valid_attributes) do
    {
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      price: 10.99,
      published_date: Date.new(1925, 4, 10)
    }
  end

  describe "validations" do
    # Sunny Day Tests
    it "is valid with all attributes" do
      book = Book.new(valid_attributes)
      expect(book).to be_valid
    end

    # Title Tests
    it "is invalid without a title" do
      book = Book.new(valid_attributes.except(:title))
      expect(book).not_to be_valid
      expect(book.errors[:title]).to be_present
    end

    # Author Tests
    it "is invalid without an author" do
      book = Book.new(valid_attributes.except(:author))
      expect(book).not_to be_valid
      expect(book.errors[:author]).to be_present
    end

    # Price Tests
    it "is invalid without a price" do
      book = Book.new(valid_attributes.except(:price))
      expect(book).not_to be_valid
      expect(book.errors[:price]).to be_present
    end

    it "is invalid with a negative price" do
      book = Book.new(valid_attributes.merge(price: -5.00))
      expect(book).not_to be_valid
      expect(book.errors[:price]).to be_present
    end

    it "is invalid with a zero price" do
      book = Book.new(valid_attributes.merge(price: 0.00))
      expect(book).not_to be_valid
      expect(book.errors[:price]).to be_present
    end

    # Published Date Tests
    it "is invalid without a published_date" do
      book = Book.new(valid_attributes.except(:published_date))
      expect(book).not_to be_valid
      expect(book.errors[:published_date]).to be_present
    end
  end
end