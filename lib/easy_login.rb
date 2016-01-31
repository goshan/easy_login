require "easy_login/version"

module EasyLogin
	def self.helper_method
		[:sign_in?, :current_user, :current_user?]
	end
end
