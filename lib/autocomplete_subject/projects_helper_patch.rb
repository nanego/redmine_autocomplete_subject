require_dependency 'projects_helper'

module PluginAutocompleteSubject

  module ProjectsHelper

    def project_settings_tabs
      tabs = super
      if @project.module_enabled?("autocomplete_subject")
        autocomplete_subject_tab = {name: :autocomplete_subject, action: :autocomplete_subject, partial: 'projects/autocomplete_subject_tab', label: :autocomplete_subject}
        tabs << autocomplete_subject_tab
      end
      tabs
    end

  end

end

ProjectsHelper.prepend PluginAutocompleteSubject::ProjectsHelper
ActionView::Base.send(:include, ProjectsHelper)
