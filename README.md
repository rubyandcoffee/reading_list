# Project Name

A Ruby on Rails application for managing your library and tracking your reading goals.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Running the Application](#running-the-application)
- [Usage](#usage)
- [Running Tests](#running-tests)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Comprehensive Book Management**
  Manage and organize a library of books, authors, genres, and series effortlessly.

- **Advanced Search Functionality**
  Easily find books, authors, or genres using powerful search capabilities provided by the Ransack gem.

- **Generate PDF Reports**
  Export your customized book shopping list or other data into a professionally styled PDF, powered by Wicked PDF.

- **Book Ratings and Reviews**
  Add ratings to your books to keep track of your preferences, helping you make informed decisions about your next read.

- **Reading Goals Tracking**
  Stay motivated by setting and monitoring your personalized reading goals, ensuring steady progress in your literary journey.

- **Individual Book Status Tracking**
  Track the status of each book in your library — whether it's unread, currently reading, or completed — for seamless organization.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Make sure you have the following installed on your system:

- Ruby 3.2.2
- Rails 7.1.x
- SQLite3
- Node.js & Yarn (for Vite)

You can manage your Ruby versions using [chruby](https://github.com/postmodern/chruby).

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/rubyandcoffee/reading_list.git
    cd reading_list
    ```

2. Install dependencies:

    ```sh
    bundle install
    ```

3. Set up the database:

    ```sh
    rails db:create db:migrate db:seed
    ```

### Running the Application

Start the Rails server:

```sh
rails server
```

Alternatively you can build and run in docker:
```sh
docker build -t reading_list .
docker run -p 3000:3000 reading_list
```
Open your browser and navigate to `http://localhost:3000`.

To run Vite:
```
bin/vite dev
```

## Usage

You can easily navigate the application using the navigation bar at the top.
Filter your books in the search bar at the left, and see your TBR list on the right.

## Running Tests

To run tests, simply run:

```sh
rails test
```

## Deployment

For deploying to production, consider using a platform like Heroku, AWS, or any other service that supports Ruby on Rails applications. Make sure to configure your environment variables and database properly.

## Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-name`).
5. Create a new Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Tech Stack

- Ruby on Rails 7.1
- SQLite3 (default database)
- VueJS
- Vuetify for styling
- Vite for frontend assets
- Ransack for advanced search
- Wicked PDF for PDF export
- Chartkick for charts
- Redis for caching
- Sentry for error tracking
