# Project Name

A Ruby on Rails application for [describe your application's purpose, e.g., "managing a library of books", "tracking personal expenses", etc.].

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

- Manage books and authors
- Search functionality using Ransack
- User authentication and authorization
- Export data to PDF using Wicked PDF
- Paginate results with will_paginate

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Make sure you have the following installed on your system:

- Ruby 3.2.2
- Rails 7.0.8.4
- SQLite3
- Redis

You can manage your Ruby versions using [chruby](https://github.com/postmodern/chruby).

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
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

Open your browser and navigate to `http://localhost:3000`.

## Usage

Describe how to use the application, including any important functionality and navigation.

## Running Tests

To run tests, simply run:

```sh
rails test
```

Or if you're using RSpec:

```sh
rspec
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

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.# README

A reading list to track your current book inventory, book statuses, yearly reading goals, book shopping list, and much more.

You can also filter by author, genre, status and much more.

#### Build it
`docker build -t reading_list .`

#### Run it
`docker run -p 3000:3000 reading_list`
