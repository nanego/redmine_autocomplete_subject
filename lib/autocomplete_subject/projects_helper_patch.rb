require_dependency 'projects_helper'

module ProjectsHelper

  unless instance_methods.include?(:project_settings_tabs_with_autocomplete_subject)
    def project_settings_tabs_with_autocomplete_subject
      tabs = project_settings_tabs_without_autocomplete_subject
      if @project.module_enabled?("autocomplete_subject")
        autocomplete_subject_tab = {name: :autocomplete_subject, action: :autocomplete_subject, partial: 'projects/autocomplete_subject_tab', label: :autocomplete_subject}
        tabs << autocomplete_subject_tab
      end
      tabs
    end
    alias_method_chain :project_settings_tabs, :autocomplete_subject
  end

end
