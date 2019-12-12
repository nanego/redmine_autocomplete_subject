require_dependency 'issues_controller'

class IssuesController

  append_before_action :valid_autocompleted_subject, :only => [:create]

  private

  def valid_autocompleted_subject
    if @project.module_enabled?("autocomplete_subject")
      subject_textfield_not_activated = @project.show_subject_input != 3
      module_enabled_for_current_tracker = @project.autocomplete_subject_tracker_ids.blank? || @project.autocomplete_subject_tracker_ids.split('|').include?(@issue.tracker.id.to_s)
      if subject_textfield_not_activated && module_enabled_for_current_tracker
        @issue.subject = calculated_subject
      end
    end
  end

  def calculated_subject
    autocompleted_subject = []
    AutocompletedField.where(project_id: @issue.project_id).order('position asc').each do |f|
      field_name_array = f.field_name.split('_')
      if field_name_array.last == 'id'
        # issue property
        value = @issue.public_send(field_name_array[1..-2].join('_')).to_s
      else
        if field_name_array.last.to_i.to_s == field_name_array.last
          # Integer --> custom_field id
          value = @issue.custom_field_value(field_name_array.last.to_i).to_s
        end
      end
      autocompleted_subject << value if value.present?
    end
    autocompleted_subject.join(@project.autocomplete_separator)
  end

end
