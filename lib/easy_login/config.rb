module EasyLogin
	class Config
		attr_accessor :salt, :user_model, :user_role_attr
	end

	@@config = Config.new

	def self.configed?
		@@config.salt && @@config.user_model && @@config.user_role_attr
	end

	def self.config
		@@config
	end
    
	def self.setup
		yield @@config
	end
end
