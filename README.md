# README

This application is a trial to create API's for tracking Family Tree of a person.

* Ruby version
```ruby 2.3.0```

* Clone the repository
```
git clone https://github.com/jinifrancis/genealogy.git
```

* Insall Gems
```
bundle install
```

* Configuration

Copy the configuration files from the samples to respective ymls
```
cp config/secrets.yml.sample config/secrets.yml
cp config/database.yml.sample config/database.yml
cp config/genealogy.yml.sample config/genealogy.yml
```
Make necessary changes in the configuration files for the app to run

* Database creation and initialization
```
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

* Start the rails server
```
rails s
```
And if in localhost, navigate to http://localhost:3000/api/index to see the swagger documentation of api

[//]: * System dependencies

[//]: * How to run the test suite

[//]: * Services (job queues, cache servers, search engines, etc.)

[//]: * Deployment instructions
