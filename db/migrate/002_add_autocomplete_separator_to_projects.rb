class AddAutocompleteSeparatorToProjects < ActiveRecord::Migration[4.2]
  def self.up
    add_column :projects, :autocomplete_separator, :string
  end

  def self.down
    remove_column :projects, :autocomplete_separator
  end
end
