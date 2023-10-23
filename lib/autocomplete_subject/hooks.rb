module AutocompleteSubject::Hooks
  class ModelHook < Redmine::Hook::Listener
    def after_plugins_loaded(_context = {})
      require_relative 'projects_helper_patch'
      require_relative 'issues_controller_patch'
      require_relative 'project_patch'
      require_relative 'projects_controller_patch'
    end
  end
end
