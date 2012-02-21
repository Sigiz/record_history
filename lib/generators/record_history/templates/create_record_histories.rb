class CreateRecordHistories < ActiveRecord::Migration
  def self.up
    create_table  :record_histories do |t|
      t.string    :item_type, :null => false
      t.integer   :item_id,   :null => false
      t.string    :attr_name,   :null => false
      t.text      :old_value
      t.text      :new_value
      t.integer   :author_id
    end
    add_index :record_histories, [:item_type, :item_id, :attr_name]
  end

  def self.down
    drop_table :record_histories
  end
end


