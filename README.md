# EasyLogin

a simple session controller which just including

+ :sign_in
+ :sign_out
+ :signed_in?
+ :current_user
+ :current_user?

for controllers and

+ :current_user
+ :current_user?
+ :signed_in?

for views

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_login'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install easy_login

## Usage

Add following code into `app/controllers/application_controller.rb`

```ruby
class ApplicationController < ActionController::Base
  include EasyLogin::Session
  helper_method EasyLogin.helper_method
end
```

And then you can use all the methods above in controller and view

※ make sure that you have decalre a model named User

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/easy_login. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

