class AddAutocompleteSubjectTrackerIdsToProjects < ActiveRecord::Migration[4.2]
  def self.up
    add_column :projects, :autocomplete_subject_tracker_ids, :string
  end

  def self.down
    remove_column :projects, :autocomplete_subject_tracker_ids
  end
end
