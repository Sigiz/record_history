ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string :login, :null => false
    t.string :password, :null => false
    t.string :name, :null => false
    t.timestamps
  end

  create_table :some_data do |t|
    t.string :name, :null => false
    t.string :description, :null => false
    t.string :value
    t.timestamps
  end

  create_table  :record_histories do |t|
    t.string    :item_type, :null => false
    t.integer   :item_id,   :null => false
    t.string    :attr_name
    t.text      :old_value_dump
    t.text      :new_value_dump
    t.string    :author_type
    t.integer   :author_id
    t.datetime  :created_at
    t.decimal   :transaction_id, :null => false
  end
  add_index :record_histories, [:item_type, :item_id, :attr_name]
  add_index :record_histories, [:item_type, :item_id]
  add_index :record_histories, [:author_type, :author_id]
  add_index :record_histories, :transaction_id
end
