require_dependency 'projects_controller'

class ProjectsController < ApplicationController

    after_action :set_default_parameters_for_autocomplete_subject, :only => [:update, :create]

    private

    def set_default_parameters_for_autocomplete_subject
      default_separator = "-"
      default_field = "issue_tracker_id"
      if @project.enabled_module_names.include? "autocomplete_subject"
        if @project.autocomplete_separator.nil? 
          @project.autocomplete_separator =  default_separator ;
        end  
        if AutocompletedField.where(project_id: @project.id).blank?
          AutocompletedField.create(project_id: @project.id, field_object: 'Issue', field_name: default_field, position: 0)
        end 
      end
      @project.save
    end

end    