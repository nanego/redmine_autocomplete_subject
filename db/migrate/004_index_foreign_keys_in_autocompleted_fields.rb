class IndexForeignKeysInAutocompletedFields < ActiveRecord::Migration
  def change
    add_index :autocompleted_fields, :project_id
  end
end
