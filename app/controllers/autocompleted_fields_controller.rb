class AutocompletedFieldsController < ApplicationController

  def update_by_project
    project = Project.find(params[:autocomplete_pattern][:project_id])
    if params["separator"].blank?
      flash['error'] = l(:autocomplete_subject_separator_required)
    elsif !params[:selected_fields].present?
      flash['error'] = l(:autocomplete_subject_field_required)
    else 
      AutocompletedField.where(project_id: project.id).delete_all

      params[:selected_fields].each_with_index do |field_name, index|
        AutocompletedField.create(project_id: project.id,
                                  field_object: 'Issue',
                                  field_name: field_name,
                                  position: index
        )
      end

      project.autocomplete_separator = params["separator"]
      project.show_subject_input = params["show_subject_input"] if params["show_subject_input"].present?
      project.autocomplete_subject_tracker_ids = params["autocomplete_subject_tracker_ids"].join('|') if params["autocomplete_subject_tracker_ids"].present?
      project.save
    end

    redirect_to settings_project_path(id: project.identifier, tab: 'autocomplete_subject')

  end

end
