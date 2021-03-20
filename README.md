# chargen-rails

This project will serve as a toy project for practicing Ruby on Rails development. It will implement at least
a subset of the rules for creating a character in a tabletop RPG, such as AD&D 2nd edition, etc. It likely won't
implement the full process, since ultimately, this is a toy project that's being used to practice a few things:

* Ruby on Rails
* RSpec
  * Unit (model) tests
  * Integration (request) tests
  * E2E (system) tests with Capybara 
  * TDD with all of the above
* Ruby in general
* Possibly some front-end type work

## Getting Started

### Prerequisites

Be sure to have the latest versions of the following installed:

* [Git](https://git-scm.com/)
  * This is what you need to pull the code down to your machine and submit changes to the repo
* [Ruby on Rails](https://guides.rubyonrails.org/getting_started.html)
  * This is the primary framework driving everything

As for Ruby itself, this is currently using version 2.7.2. Here's a few guides on managing your Ruby version(s):

* [rbenv](https://github.com/rbenv/rbenv#installation) (my personal preference)
  * This is why there's a `.ruby-version` file in the project, other Ruby version managers should ignore this
* [rvm](https://rvm.io/) (**Note:** this is INCOMPATIBLE with rbenv!)
* [asdf](https://asdf-vm.com/#/core-manage-asdf)

### Installing

* Make a folder for the code and run `git clone https://github.com/tomizechsterson/chargen-rails`
  * This will pull down the latest version of the code and copy it into the `chargen-rails` folder
* Navigate into this folder with your terminal of choice
* Run `bundle install --without production` to pull down all the Ruby-related dependencies and prevent any
  production-only gems from installing locally
* Run `yarn` to install all the non-Ruby dependencies
* Run `rails db:migrate` to run all the migrations and get your database setup

At this point, you should have everything you need to fire up your IDE of choice and start tinkering. If not,
feel free to open an issue and I'll see what I can do.

## Getting Going

### Running the App

Simply run `rails s` in your terminal at the root of the project, and this should start up the development server.
From here, you can navigate your browser to `http://localhost:3000/` to see the classic Rails hello world page
(for now)

### Running the Tests

You can run `rspec` at the root of the project to run the entire test suite. This is pretty good most of the time,
however, when the E2E (system) test suite starts growing in size, the test runs will slow down noticeably.
When this starts happening, it's good to run `rspec spec/models spec/requests` to run the unit and integration
tests during development. This gives you a fast and thorough feedback loop while you're writing your code.

Then, when you get to the end of the feature or bug you're working on, remember to run `rspec`
or `rspec spec/system` to make sure the user experience that's represented by the E2E tests still works. 

## Contributions

You're welcome to contribute if you'd like. Simply open a PR and I'll be happy to review it. I can't promise to be
timely, but I will certainly try :)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
