module EasyLogin
	module Session
		def signed_in?
			return !current_user.nil?
		end

		def current_user?(user)
			if(user == nil || current_user == nil)
				return false;
			end
			return user.id == current_user.id
		end

		def sign_in(user)
			cookies.signed[:f] = [user.id, EasyLogin.config.salt]
		end

		def sign_out
			cookies.delete(:f)
		end

		def current_user
			user_from_session_token
		end

		private
		def user_from_session_token
			user_id = session_token[0]
			return nil if user_id == nil
			user = EasyLogin.config.user_model.cap.capitalize.constantize.find_by_id(user_id)
			return user
		end

		def session_token
			session = cookies.signed[:f] || [nil, nil]
			return [nil, session[1]] unless session[1] == EasyLogin.config.salt
			session
		end
	end
end
