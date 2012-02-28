class CreateRecordHistories < ActiveRecord::Migration
  def self.up
    create_table  :record_histories do |t|
      t.string    :item_type, :null => false
      t.integer   :item_id,   :null => false
      t.string    :attr_name
      t.text      :old_value_dump
      t.text      :new_value_dump
      t.string    :author_type
      t.integer   :author_id
      t.datetime  :created_at
    end
    add_index :record_histories, [:item_type, :item_id, :attr_name]
    add_index :record_histories, [:item_type, :item_id]
    add_index :record_histories, [:author_type, :author_id]
  end

  def self.down
    drop_table :record_histories
  end
end


