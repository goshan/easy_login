require "base64"
require "digest/md5"
require "json"
require "time"
require "easy_login/version"
require "easy_login/config"
require "easy_login/session"
require "easy_login/grape_helper"
require "easy_login/permission"

module EasyLogin
	def self.helper_method
		[:signed_in?, :current_user, :current_user?]
	end

	class Railtie < Rails::Railtie
		config.to_prepare do
			unless EasyLogin.configed?
				EasyLogin.setup do |config|
					config.salt = "salt_from_goshan"
					config.user_model = "User"
					config.user_role_attr = "role"
				end
			end
		end
	end
	
  def self.included(base)
    base.send :include, Session
    if base == ApplicationController
      base.helper_method EasyLogin.helper_method
      base.send :before_action do |controller|
        Permission.action controller
      end
    elsif base == ApplicationCable::Connection
      base.send :identified_by, :client
    elsif base == Grape::API || base.superclass == Grape::API
      base.helpers GrapeHelper
    end
  end

  def self.cable_authorize(connection, current_user)
    connection.client = current_user
  end

end
