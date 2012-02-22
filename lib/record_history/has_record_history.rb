module RecordHistory
	module Model

		def self.included(base)
      base.send :extend, ClassMethods
    end

		module ClassMethods
			def has_record_history(options={})
				send :include, InstanceMethods

				attr_accessor :record_history_obj

				class_attribute :ignore
        self.ignore = ([options[:ignore]].flatten.compact || []).map &:to_s

        class_attribute :only
        self.only = ([options[:only]].flatten.compact || []).map{|attr| attr.to_s}

				has_many :record_history,
                 :class_name => 'RecordHistoryModel',
                 :order      => "created_at DESC",
                 :as         => :item

        before_save :build_record_history_obj
        after_save :save_record_history_obj
			end
		end

		module InstanceMethods


			def build_record_history_obj
        self.record_history_obj ||= []
				self.class.new.attributes.keys.each do |attr_name|
					if (self.send("#{attr_name}_changed?"))
						self.record_history_obj << RecordHistoryModel.new(
											:item_type => self.class.name,
                      :item_id => self.id,
                      :attr_name => attr_name,
                      :old_value => self.send("#{attr_name}_was"),
                      :new_value => self.send("#{attr_name}"),
                      :author_id => nil
						)
					end
				end
			end

			def save_record_history_obj
        self.record_history_obj.each{|item| item.save}
			end
		end
	end
end
