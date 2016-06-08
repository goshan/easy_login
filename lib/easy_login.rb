require "easy_login/version"
require "easy_login/config"
require "easy_login/session"

module EasyLogin
	def self.helper_method
		[:signed_in?, :current_user, :current_user?]
	end
end
