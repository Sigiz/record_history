require "record_history/version"
require "record_history/record_history_model"
require "record_history/has_record_history"

module RecordHistory

end

ActiveSupport.on_load(:active_record) do
  include RecordHistory::Model
end