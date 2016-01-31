require "easy_login/version"
require "easy_login/session"

module EasyLogin
	def self.helper_method
		[:sign_in?, :current_user, :current_user?]
	end
end
