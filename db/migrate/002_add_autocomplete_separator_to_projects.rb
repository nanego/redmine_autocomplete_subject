class AddAutocompleteSeparatorToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :autocomplete_separator, :string
  end

  def self.down
    remove_column :projects, :autocomplete_separator
  end
end
