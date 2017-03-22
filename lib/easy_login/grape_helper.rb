module EasyLogin
  module GrapeHelper
    def signed_in?
      return !current_user.nil?
    end

    def current_user?(user)
      if(user == nil || current_user == nil)
        return false;
      end
      return user.id == current_user.id
    end

    def current_user
      user_id = session_info[0]
      return nil if user_id == nil
      user = EasyLogin.config.user_model.capitalize.constantize.find_by_id(user_id)
      return user
    end

    def authorize!
      unless current_user
        logger.info "Error 403: User authorization failed"
        error!({:error => "authorize_failed", :msg => "User authorization failed"}, 403)
      end
    end

    private
    def session_info
      session = cookies[:f]
      # cookie signed failed
      return [nil, nil] unless session
      session = Base64.decode64 cookies[:f].split('--').first
      begin
        session = JSON.parse session
      rescue
        return [nil, nil]
      end
      digest = Digest::MD5.hexdigest "#{session[0]},#{EasyLogin.config.salt},#{Time.parse(session[1]).to_i}"
      # digest check failed
      return [nil, nil] unless session[2] == digest
      [session[0], session[1]]
    end
  end
end
