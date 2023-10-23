require_dependency 'projects_helper'

module AutocompleteSubject

  module ProjectsHelperPatch

    def project_settings_tabs
      tabs = super
      if @project.module_enabled?("autocomplete_subject") && User.current.allowed_to?(:set_autocomplete_subject_pattern, @project)
        autocomplete_subject_tab = { name: 'autocomplete_subject', action: :autocomplete_subject, partial: 'projects/settings_autocomplete_subject_tab', label: :autocomplete_subject }
        tabs << autocomplete_subject_tab
      end
      tabs
    end

  end

end

ProjectsHelper.prepend AutocompleteSubject::ProjectsHelperPatch
ActionView::Base.send(:include, ProjectsHelper)
