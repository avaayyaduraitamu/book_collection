# Book Collection App

A Ruby on Rails 7 application for managing a personal book collection with CRUD operations.

## Prerequisites

- Docker (with the paulinewade/csce431:sp26v1 image)
- Port 3000 available on your host machine

## Setup & Running the Application

### 1. Start the Docker Container

From the project root directory (`csce431/`), run:

```bash
docker run -it -v "$(pwd):/app" -p 3000:3000 paulinewade/csce431:sp26v1
```

This command:
- `-it` - Interactive terminal
- `-v "$(pwd):/app"` - Mounts your current directory into the container
- `-p 3000:3000` - Maps port 3000 from container to host

### 2. Inside the Container - Set Up Database

Once inside the container, set the database URL and run migrations:

```bash
cd /app/test_app
export DATABASE_URL="postgresql://postgres:postgres@127.0.0.1:5432/test_app_development"
rails db:migrate
```

### 3. Start the Rails Server

```bash
rails server -b 0.0.0.0
```

You should see output like:
```
* Listening on http://0.0.0.0:3000
```

### 4. Access the Application

Open your browser and navigate to:

```
http://localhost:3000/books
```

## Features

- **View All Books** - Home page lists all books with action links
- **Create Book** - Click "New book" to add a new book
- **Read Book** - Click "Show" to view book details
- **Update Book** - Click "Edit" to modify a book
- **Delete Book** - Click "Delete" to remove a book (with confirmation)
- **Flash Notices** - Success messages appear after each action

## Models & Attributes

### Book Model
- `title` (String) - The title of the book
- `created_at` (DateTime) - Automatically tracked
- `updated_at` (DateTime) - Automatically tracked

## Routes

The application uses Rails resourceful routing:

```
GET    /books              # List all books (index)
GET    /books/new          # New book form
POST   /books              # Create a book
GET    /books/:id          # Show book details
GET    /books/:id/edit     # Edit book form
PATCH  /books/:id          # Update a book
DELETE /books/:id          # Delete a book
```

## Troubleshooting

**Database Connection Error:**
If you get "connection failed: fe_sendauth: no password supplied", ensure the DATABASE_URL is set:
```bash
export DATABASE_URL="postgresql://postgres:postgres@127.0.0.1:5432/test_app_development"
```

**Port Already in Use:**
If port 3000 is in use, you can specify a different port:
```bash
rails server -b 0.0.0.0 -p 3001
```
Then access via `http://localhost:3001/books`

## Testing the Application

1. Navigate to http://localhost:3000/books
2. Click "New book" to create a test book
3. Enter a book title and submit
4. From the home page, test:
   - Click "Show" to view details
   - Click "Edit" to modify the book
   - Click "Delete" to remove it (confirm the dialog)
