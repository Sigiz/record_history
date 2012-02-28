module RecordHistory
  module Controller
    def self.included(base)
      base.before_filter :set_record_history_author
    end

    protected

    def author_for_record_history
      current_user rescue nil
    end

    def set_record_history_author
      ::RecordHistory.author = author_for_record_history
    end
  end
end
