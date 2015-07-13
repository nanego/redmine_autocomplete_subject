class AutocompletedField < ActiveRecord::Base

  belongs_to :project

  attr_accessible :field_object, :field_name, :position, :project_id

  def to_s
    self.field_name
  end

end
