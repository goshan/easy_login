require 'rails/generators/base'

module EasyLogin
  class InitGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)
    desc 'EasyLogin Initialize'

    def init_steps
      copy_file 'http_permissions.yml', 'config/http_permissions.yml'
    end
  end
end
