class AddShowSubjectInputToProjects < ActiveRecord::Migration[4.2]
  def self.up
    add_column :projects, :show_subject_input, :integer
  end

  def self.down
    remove_column :projects, :show_subject_input
  end
end
