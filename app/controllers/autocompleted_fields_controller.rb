class AutocompletedFieldsController < ApplicationController

  def update_by_project

    project = Project.find(params[:autocomplete_pattern][:project_id])
    AutocompletedField.delete_all(project_id: project.id)

    params[:selected_fields].each_with_index do |field_name, index|
      AutocompletedField.create(project_id: project.id,
                                 field_object: 'Issue',
                                 field_name: field_name,
                                 position: index
      )
    end if params[:selected_fields].present?

    project.autocomplete_separator = params["separator"] if params["separator"].present?
    project.show_subject_input = params["show_subject_input"] if params["show_subject_input"].present?
    project.save

    redirect_to settings_project_path(id: project.identifier, tab: 'autocomplete_subject')

  end

end
