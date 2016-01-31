# EasyLogin

a simple session controller which just including

+ :sign_in
+ :sign_out
+ :sign_in?
+ :current_user
+ :current_user?

for controllers and

+ :current_user
+ :current_user?
+ :sign_in?

for views

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_login'
```

And then execute:

    $ bundle

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/easy_login. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

