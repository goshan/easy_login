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

Added config in `config/application.rb` or `config/environments/*.rb`

```ruby
EasyLogin.setup do |config|
	config.salt = "same_salt_string"
	config.user_model = "your user model such as 'User'"
	config.user_role_attr = "your role attribute in user model such as 'role'"
end
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
otherwise --> means using as absolute url string
```



## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

