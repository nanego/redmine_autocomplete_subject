require_dependency 'projects_controller'

module AutocompleteSubject::ProjectsControllerPatch

  def set_default_parameters_for_autocomplete_subject
    if @project.module_enabled?("autocomplete_subject")
      default_separator = "-"
      default_field = "issue_tracker_id"
      @project.autocomplete_separator = default_separator if @project.autocomplete_separator.blank?
      @project.autocompleted_fields << AutocompletedField.new(field_object: 'Issue', field_name: default_field, position: 0) if @project.autocompleted_fields.blank?
      @project.save
    end
  end

end

class ProjectsController < ApplicationController

  include AutocompleteSubject::IssuesControllerPatch

  after_action :set_default_parameters_for_autocomplete_subject, :only => [:update, :create]

end    
