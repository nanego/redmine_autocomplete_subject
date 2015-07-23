require 'redmine'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'autocomplete_subject/projects_helper_patch'
end

Redmine::Plugin.register :redmine_autocomplete_subject do
  name 'Redmine Autocomplete Subject plugin'
  author 'Vincent ROBERT'
  description 'This is a plugin for Redmine'
  version '1.0.0'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :autocomplete_subject do
    permission :set_autocomplete_subject_pattern, {  }
  end

end
