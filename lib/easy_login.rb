require "easy_login/version"
require "easy_login/config"
require "easy_login/session"
require "easy_login/redirect"

module EasyLogin
	def self.helper_method
		[:signed_in?, :current_user, :current_user?]
	end

	class Railtie < Rails::Railtie
		initializer "load this gem to controller" do
			ApplicationController.send :include, EasyLogin
		end

		config.to_prepare do
			unless EasyLogin.setup do |config|
				config.salt = "salt_from_goshan"
				config.user_model = "User"
				config.user_role_attr = "role"
			end
		end
	end
	
	def self.included(base)
		base.send :include, Session
		base.helper_method EasyLogin.helper_method
		base.send :before_action do |controller|
			Redirect.parse controller
		end
	end

end
