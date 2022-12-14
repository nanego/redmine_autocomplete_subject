require_dependency 'project'

class Project
  has_many :autocompleted_fields, :dependent => :destroy
end

module PluginAutocompleteSubject
  module ProjectModel
    # Copies all parameters of autocomplete_subject from +project+
    def copy_autocomplete_subject(project)
      autocompletedField = AutocompletedField.where(project_id: project.id)
      autocompletedField.each do |field|
        AutocompletedField.create(project_id: self.id,
          field_object: field.field_object,
          field_name: field.field_name,
          position: field.position
        )
      end
      self.autocomplete_separator = project.autocomplete_separator
      self.show_subject_input = project.show_subject_input
      self.autocomplete_subject_tracker_ids = project.autocomplete_subject_tracker_ids
    end

    def copy(project, options={})
      super
      project = project.is_a?(Project) ? project : Project.find(project)

      to_be_copied = %w(autocomplete_subject)

      to_be_copied = to_be_copied & Array.wrap(options[:only]) unless options[:only].nil?

      Project.transaction do
        if save
          reload

          to_be_copied.each do |name|
            send "copy_#{name}", project
          end

          save
        else
          false
        end
      end
    end
  end
end

Project.prepend PluginAutocompleteSubject::ProjectModel