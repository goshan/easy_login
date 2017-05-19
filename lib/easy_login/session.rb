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
      timestamp = Time.now.to_i
      digest = Digest::MD5.hexdigest "#{user.id},#{EasyLogin.config.salt},#{timestamp}"
			cookies.signed[:f] = [user.id, Time.at(timestamp).to_s, digest]
		end

		def sign_out
			cookies.delete(:f)
		end

		def current_user
			user_id = session_info[0]
			return nil if user_id == nil
			user = EasyLogin.config.user_model.capitalize.constantize.find_by_id(user_id)
			return user
		end

    def easy_login_session
      session = cookies.signed[:f]
      "<div id='easy_login_session' uid=#{session[0]} ts='#{session[1]}' d='#{session[2]}'></div>".html_safe
    end

		private
    def session_info
      session = cookies.signed[:f]
      # cookie signed failed
			return [nil, nil] unless session
      digest = Digest::MD5.hexdigest "#{session[0]},#{EasyLogin.config.salt},#{Time.parse(session[1]).to_i}"
      # digest check failed
      return [nil, nil] unless session[2] == digest
			[session[0], session[1]]
		end
	end
end
