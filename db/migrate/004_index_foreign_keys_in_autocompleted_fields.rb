class IndexForeignKeysInAutocompletedFields < ActiveRecord::Migration[4.2]
  def change
    add_index :autocompleted_fields, :project_id
  end
end
