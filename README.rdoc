# [Funma.pl](http://funma.pl) 

This is the source code of [funma.pl](http://funma.pl) project. Using funma.pl, you can check out the fun & cheap events in your city. You can filter the events according to date or category you want. For the time being, only events ins SF Bay area are listed but more to come soon :) 

## Development

The project is developed using Ruby/Rails, jQuery UI Widgets and Google Maps Api. Bootstrap is used for styling web components. Events are fetched from Sf.funcheap.com's RSS feeds. [Superfeedr](http://superfeedr.com) is used for subscribing RSS feeds. 

Funma.pl is hosted on an [Amazon Ec2](http://aws.amazon.com/ec2/) server.

## How to get it work
- Install ruby version 2.0.0 and rails version 4.0.0 (for detailed information about installation, you can follow [Micheal Hartl's tutorial](http://ruby.railstutorial.org/ruby-on-rails-tutorial-book)

- Install mysql (Mysql is not the default db vendor of Rails framework, so change your adaptor to mysql in database.yml file)

- You should subscribe to an RSS publisher to get the events. I subscribed to sf.funcheap using superfeedr project.

- Additional gems used are:
    - nokogiri: To parse HTML
    - bootstrap-rails: Twitter Bootstrap Project
    - momentjs-rails: Daterangepicker ui relies on
    - bootstrap-daterangepicker-rails: Daterangepicker jquery ui widget by dangrossman