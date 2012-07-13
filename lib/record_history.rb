require "record_history/version"
require "record_history/record_history_model"
require "record_history/controller"
require "record_history/has_record_history"

module RecordHistory

  def self.author=(value)
    Thread.current[:author] = value
  end

  def self.author
    Thread.current[:author]
  end

end

ActiveSupport.on_load(:active_record) do
  include RecordHistory::Model
end

ActiveSupport.on_load(:action_controller) do
  include RecordHistory::Controller
end
