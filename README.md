
Change Log
============

This sample app creates two interfaces Admin and User respectively.

Admin Role:
==============

* `Can create transaction for own` 
* `can view Payback Points of other users`

User Role:
=================

* `Can create transaction for own`

Application Start
=======================

* `clone the repo`
* `bundle install`
* `rake db:create db:migrate`
* `rails s`
* `redis-server`- for sidekicq 
* `bundle exec sidekiq` - for payback points calculation on the fly
* `rspec`- for testing

Gems Used
=======================
* `Devise` User Authentication
* `CanCan` User Roles, authorisation
* `Bootstrap` Simple elegant views
* `pg` postgres
* `sidekiq` Job scheduling
* `rspec` testing
* `Factory girl` testing and mocking
