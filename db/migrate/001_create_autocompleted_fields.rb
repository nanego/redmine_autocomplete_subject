class CreateAutocompletedFields < ActiveRecord::Migration[4.2]
  def self.up
    create_table :autocompleted_fields do |t|
      t.column :project_id, :integer
      t.column :field_object, :string
      t.column :field_name, :string
      t.column :position, :integer
    end
  end

  def self.down
    drop_table :autocompleted_fields
  end
end
