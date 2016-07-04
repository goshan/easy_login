module EasyLogin
	class Redirect
		def self.parse(controller_ins)
			per YAML.load_file Rails.root.join "config", "redirect_to.yml"
			controller = controller_ins.params[:controller]
			action = controller_ins.params[:action]
			p = per[controller]
			p = p[action] || p['default'] if p
			p = per['default'] unless p
			if controller_ins.signed_in?
				url = p[controller_ins.current_user.send(EasyLogin.config.user_role_attr)]
			else
				url = p['unsign']
			end
			if url
				raise ActionController::RoutingError.new("Routing Error") if url == 404
				url = controller_ins.send url if url.end_with? "path"
				controller_ins.redirect_to url
			end
		end
	end
end
