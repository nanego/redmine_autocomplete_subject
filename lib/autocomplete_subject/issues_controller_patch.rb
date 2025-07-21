require_dependency 'issues_controller'

module AutocompleteSubject::IssuesControllerPatch

  def valid_autocompleted_subject
    if @issue.project.present? && @issue.project.module_enabled?("autocomplete_subject")
      subject_textfield_not_activated = @issue.project.show_subject_input != 3
      module_enabled_for_current_tracker = @issue.project.autocomplete_subject_tracker_ids.blank? || @issue.project.autocomplete_subject_tracker_ids.split('|').include?(@issue.tracker.id.to_s)
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
      elsif field_name_array.last.to_i.to_s == field_name_array.last
        # Integer --> custom_field id
        value = @issue.custom_field_value(field_name_array.last.to_i).to_s
      else
        # standard fields (ex: start_date, due_date, subject, etc.)
        value = @issue.public_send(field_name_array[1..-1].join('_')).to_s
      end
      autocompleted_subject << value if value.present?
    end
    autocompleted_subject.join(@issue.project.autocomplete_separator)
  end

end

class IssuesController

  include AutocompleteSubject::IssuesControllerPatch

  append_before_action :valid_autocompleted_subject, :only => [:create]

end
