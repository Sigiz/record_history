class AlterRecordHistoriesAddTransactionId < ActiveRecord::Migration
  def self.up
    add_column :record_histories, :transaction_id, :decimal
    RecordHistoryModel.all.each do |rec|
      rec.transaction_id = rec.created_at.to_f
      rec.save
    end
    change_column :record_histories, :transaction_id, :decimal, :null => false
    add_index :record_histories, :transaction_id
  end
  def self.down
    remove_column :record_histories, :transaction_id
  end
end
