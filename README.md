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

And then run command to init a config file

	$ bundle exec rails generate easy_login:init

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
controller and action by editing config file `config/http_permissions.yml`

The following is a default code of `config/http_permissions.yml`

```yaml
default:
  ope: pass
  customer: pass
  unsigned: redirect_to->login_users_path
users:
  login:
    ope: redirect_to->root_path
    customer: redirect_to->root_path
tools:
  default:
    customer: raise->Routing Error
    unsigned: redirect_to->/tools/login
  login:
    ope: redirect_to->tools_path
    customer: raise->Other Error
```

The basic format for this permission schema is like

```yaml
controller:
  action:
    user_role1: pass
    user_role2: redirect_to->{path}
    user_role3: raise->{message}
```

The `user_role` if the role attribute of your user model configed in `config/application.rb` or `config/environments/*.rb`  
  
The `action` has 3 types

```
pass --> run the logic in action normally
redirect_to --> redirect to other {path}, {path} also has two types, {xxx_path} means using rails routing method, and {other format} means used as absolute url string
raise --> raise a 404 response with {message}
```

If the schema was not defined in controller/action/user_role, the schema in controller/default/user_role will be used, Also, if it was not defined in controller/default/user_role, default/user_role will be used, if still default/user_role could not be found, easylogin will do action same as 'pass'

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

