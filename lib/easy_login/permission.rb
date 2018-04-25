module EasyLogin
  class Permission
    def self.action(controller_ins)
      url = self.parse controller_ins
      if url
        params = url.split '->'
        return if params[0] == "pass"
        raise ActionController::RoutingError.new(params[1]) if params[0] == "raise"
        if params[0] == "redirect_to"
          params[1] = controller_ins.send params[1] if params[1].end_with? "path"
          controller_ins.redirect_to params[1]
        end
      end
    end

    private
    def self.parse(controller_ins)
      per = YAML.load_file Rails.root.join "config", "http_permissions.yml"
      controller = controller_ins.params[:controller]
      action = controller_ins.params[:action]

      default = nil
      role = controller_ins.signed_in? ? controller_ins.current_user.send(EasyLogin.config.user_role_attr) : 'unsigned'
      default = per['default'][role] if per['default'] && per['default'][role]

      return default unless per[controller]
      per = per[controller]
      default = per['default'][role] if per['default'] && per['default'][role]

      return default unless per[action]
      per = per[action]
      return per[role] || default
    end
  end
end
