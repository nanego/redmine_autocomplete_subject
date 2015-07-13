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

    redirect_to settings_project_path(id: project.identifier, tab: 'autocomplete_subject')

  end

end
