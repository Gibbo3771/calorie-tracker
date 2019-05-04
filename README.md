# calorie-tracker
Pure HTML/CSS front end a calorie tracker with a Sinatra RESTful backend. 
This application allows you to log foods and calories to keep track of your day to day intake.

## Building

*You will need at least Ruby 2.6.0 to run the application, some of the classes use String functions that are not available
in older 2.4.x versions.*

Clone the project to your machine and then run

```
gem install bundler && bundle install
rake
rackup
```

You can then go to `localhost:9292` and play around with the application.

