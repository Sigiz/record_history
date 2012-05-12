class AlterRecordHistoriesAddTransactionId < ActiveRecord::Migration
  def self.up
    add_column :record_histories, :transaction_id, :decimal
    RecordHistoryModel.update_all("transaction_id = extract(epoch from created_at)")
    change_column :record_histories, :transaction_id, :decimal, :null => false
    add_index :record_histories, :transaction_id
  end
  def self.down
    remove_column :record_histories, :transaction_id
  end
end
