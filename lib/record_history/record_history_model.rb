require 'base64'

class RecordHistoryModel < ActiveRecord::Base
	self.table_name = "record_histories"

	belongs_to :item, :polymorphic => true
	belongs_to :author, :polymorphic => true
	validates :item_type, :item_id, { :presence => true }
	validates :old_value_dump, :new_value_dump, :presence => { :unless => Proc.new{|record| record.attr_name.blank?} }

	def old_value
		self.old_value = nil if self.old_value_dump.nil?
		self.old_value_dump.nil? ? nil : decode_value(self.old_value_dump)
	end

	def old_value=(value)
		self.old_value_dump = encode_value(value)
	end

	def new_value
		self.new_value = nil if self.new_value_dump.nil?
		decode_value(self.new_value_dump)
	end

	def new_value=(value)
		self.new_value_dump = encode_value(value)
	end

	private

	def encode_value(value)
		Base64.encode64(Marshal.dump(value))
	end

	def decode_value(value)
		Marshal.load(Base64.decode64(value))
	end
end