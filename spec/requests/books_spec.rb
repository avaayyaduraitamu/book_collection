
# spec/requests/books_spec.rb
require 'rails_helper'

RSpec.describe "Books", type: :request do
  let(:valid_attributes) do
    {
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      price: 10.99,
      published_date: Date.new(1925, 4, 10)
    }
  end

  describe "POST /books (create)" do
    context "with valid parameters" do
      it "creates a book and redirects with a success message" do
        get "/books/new"
        expect(response).to have_http_status(:success)

        post "/books", params: { book: valid_attributes }
        
        expect(response).to redirect_to(book_path(Book.last))
        follow_redirect!
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Book was successfully created")
      end
    end

    context "with invalid parameters" do
      it "does not create a book with a blank title" do
        post "/books", params: { book: valid_attributes.merge(title: "") }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Title can&#39;t be blank")
      end

      it "does not create a book with a blank author" do
        post "/books", params: { book: valid_attributes.merge(author: "") }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Author can&#39;t be blank")
      end

      it "does not create a book with a blank price" do
        post "/books", params: { book: valid_attributes.merge(price: "") }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Price can&#39;t be blank")
      end

      it "does not create a book with a negative price" do
        post "/books", params: { book: valid_attributes.merge(price: -5.00) }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("must be greater than 0")
      end

      it "does not create a book with a blank published date" do
        post "/books", params: { book: valid_attributes.merge(published_date: "") }
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Published date can&#39;t be blank")
      end
    end
  end

  describe "GET /books (index)" do
    it "shows all books on the index page" do
      Book.create!(title: "Test Book", author: "Test Author", price: 15.99, published_date: Date.new(2020, 1, 1))
      
      get "/books"
      
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test Book")
      expect(response.body).to include("Test Author")
    end
  end

  describe "GET /books/:id (show)" do
    it "shows individual book details" do
      book = Book.create!(title: "Test Book", author: "Test Author", price: 15.99, published_date: Date.new(2020, 1, 1))
      
      get "/books/#{book.id}"
      
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test Book")
      expect(response.body).to include("Test Author")
      expect(response.body).to include("15.99")
    end
  end

  describe "PATCH /books/:id (update)" do
    it "updates the book successfully" do
      book = Book.create!(title: "Old Title", author: "Old Author", price: 10.00, published_date: Date.new(2020, 1, 1))
      
      patch "/books/#{book.id}", params: { 
        book: { 
          title: "New Title",
          author: "New Author",
          price: 20.00,
          published_date: Date.new(2021, 1, 1)
        } 
      }
      
      expect(response).to redirect_to(book_path(book))
      follow_redirect!
      expect(response.body).to include("Book was successfully updated")
      
      book.reload
      expect(book.title).to eq("New Title")
      expect(book.author).to eq("New Author")
      expect(book.price).to eq(20.00)
    end
  end

  describe "DELETE /books/:id (destroy)" do
    it "deletes the book successfully" do
      book = Book.create!(title: "Test Book", author: "Test Author", price: 15.99, published_date: Date.new(2020, 1, 1))
      
      delete "/books/#{book.id}"
      
      expect(response).to redirect_to(books_path)
      follow_redirect!
      expect(response.body).to include("Book was successfully deleted")
      expect(Book.find_by(id: book.id)).to be_nil
    end
  end
end