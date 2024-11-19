require 'redmine'
require_relative 'lib/autocomplete_subject/hooks'

Redmine::Plugin.register :redmine_autocomplete_subject do
  name 'Redmine Autocomplete Subject plugin'
  author 'Vincent ROBERT'
  description 'This is a plugin for Redmine'
  version '1.0.0'
  url 'https://github.com/nanego/redmine_autocomplete_subject'
  author_url 'mailto:contact@vincent-robert.com'

  project_module :autocomplete_subject do
    permission :set_autocomplete_subject_pattern, {  }
  end

end

# Support for Redmine 5
if Redmine::VERSION::MAJOR < 6
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
