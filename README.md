# EasyLogin

A simple session controller which just including following method for
controllers

+ :sign_in
+ :sign_out
+ :signed_in?
+ :current_user
+ :current_user?

And forllowings for veiw helper

+ :current_user
+ :current_user?
+ :signed_in?

## Installation

Install it yourself as:

    $ gem install easy_login

## Usage

Add config in `config/application.rb` or `config/environments/*.rb`

```ruby
EasyLogin.setup do |config|
	config.salt = "same_salt_string"
	config.user_model = "your user model such as 'User'"
	config.user_role_attr = "your role attribute in user model such as 'role'"
end
```

Add following code to `application_controller.rb`

```ruby
include EasyLogin
```

And then abosultely use all methods above in controller and view

Also you can declare a redirect schema for differenct user accessing differect
controller and action
Add a config file to `config/redirect_to.yml` as following

```yaml
default:
  unsign: login_users_path
users:
  login:
    ope: root_path
    customer: root_path
tools:
  default:
    customer: 404
    unsign: /tools/login
  login:
    ope: tools_path
    customer: 404
```

The basic format for this redirect schema is like

```yaml
controller:
  action:
    user_role1: redirect_url
    user_role2: redirect_url
    user_role3: redirect_url
```

The `user_role` if the role attribute of your user model configed in
`config/application.rb` or `config/environments/*.rb`  
`redirect_url` has 3 types

```
404 --> means raise a 404 error name 'Routing Error'
XXXX_path --> means using rails routing method
nil --> means not redirect and render view absolutely
otherwise --> means using as absolute url string
```

*※ If you also want to use in ActionCable in Rails 5*  
Add following code to `application_cable/connection.rb`

```ruby
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include EasyLogin
    
    def connect
      reject_unauthorized_connection unless current_user
      EasyLogin.cable_authorize self, current_user
    end
  end
end
```

And then you can access authorized user in other `Channel` with client

*※ If you also want to use in GrapeAPI (just authorize with cookies like controller, not support omini auth)*  
Add following code to your root api class extends Grape::API such as `api/root.rb`

```ruby
include EasyLogin
```

And then you can use some methods below in this and any other sub classes of api
- signed_in?
- current_user
- current_user?(user)
- authorize! --> response 403 error and json if authorization failed

If you want auth for every api request, write like following

```ruby
after_validation do
	authorize!
end
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

