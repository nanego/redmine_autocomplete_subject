class AutocompletedField < ActiveRecord::Base
  include Redmine::SafeAttributes

  belongs_to :project

  safe_attributes :field_object, :field_name, :position, :project_id

  def to_s
    self.field_name
  end

end
