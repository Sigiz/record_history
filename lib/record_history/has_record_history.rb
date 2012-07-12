# -*- encoding: utf-8 -*-
module RecordHistory
  module Model

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_record_history(options={})
        send :include, InstanceMethods

        attr_accessor :record_history_obj

        class_attribute :record_history_ignore
        self.record_history_ignore = ([options[:ignore]].flatten.compact || []).map{|attr| attr.to_s}

        class_attribute :record_history_only
        self.record_history_only = ([options[:only]].flatten.compact || []).map{|attr| attr.to_s}

        class_attribute :record_history_on
        self.record_history_on = ([options[:on] || ['create', 'update']].flatten.compact).map{|attr| attr.to_s}

        class_attribute :record_history_polymorphic_group
        self.record_history_polymorphic_group = ([options[:polymorphic_group]].flatten.compact || []).map{|attr| attr.to_s}

        has_many :record_history,
                 :class_name => 'RecordHistoryModel',
                 :order      => "created_at DESC",
                 :as         => :item
        if self.record_history_on.include?('update')
          before_save  :build_history_on_update
          after_update :save_history_on_update
        end

        if self.record_history_on.include?('create')
          after_create :save_history_on_create
        end
      end

      def is_record_history_author(options={})
        has_many :written_history,
                 :class_name => 'RecordHistoryModel',
                 :order      => "created_at DESC",
                 :as         => :author
      end
    end

    module InstanceMethods
      def build_history_on_update
        return if self.new_record?
        self.record_history_obj = []
        ignore = self.attr_ignore
        self.class.new.attributes.keys.each do |attr_name|
          next unless (self.send("#{attr_name}_changed?"))

          next if ignore.include?(attr_name)
          next if !self.class.record_history_only.blank? && !self.class.record_history_only.include?(attr_name)
          next if !self.class.record_history_ignore.blank? && self.record_history_ignore.include?(attr_name)
          self.record_history_obj << RecordHistoryModel.new(
                    :item_type => self.class.name,
                    :item_id => self.id,
                    :attr_name => attr_name,
                    :old_value => self.send("#{attr_name}_was"),
                    :new_value => self.send("#{attr_name}"),
                    :author => RecordHistory.author,
                    :transaction_id => Time.now.to_f
          )
        end
        self.record_history_polymorphic_group.each do |attr|
          next if !self.send("#{attr}_type_changed?") && !self.send("#{attr}_id_changed?")
          self.record_history_obj << RecordHistoryModel.new(
                      :item_type => self.class.name,
                      :item_id => self.id,
                      :attr_name => attr,
                      :old_value => {"#{attr}_type".to_sym => self.send("#{attr}_type_was"), "#{attr}_id".to_sym => self.send("#{attr}_id_was")},
                      :new_value => {"#{attr}_type".to_sym => self.send("#{attr}_type"), "#{attr}_id".to_sym => self.send("#{attr}_id")},
                      :author => RecordHistory.author,
                      :transaction_id => Time.now.to_f
            )
        end
      end

      def attr_ignore
        attr_ignore = []
        self.record_history_polymorphic_group.each do |attr|
          if !self.reflections[attr.to_sym].options[:polymorphic]
            raise "Тип связи должен быть polymorphic"
          else
            attr_ignore += ["#{attr}_id", "#{attr}_type"]
          end
        end
        attr_ignore
      end

      def save_history_on_update
        self.record_history_obj.each{|item| item.save}
      end

      def save_history_on_create
        RecordHistoryModel.create!(
          :item_type => self.class.name,
          :item_id => self.id,
          :author => RecordHistory.author
        )
      end
    end
  end
end
